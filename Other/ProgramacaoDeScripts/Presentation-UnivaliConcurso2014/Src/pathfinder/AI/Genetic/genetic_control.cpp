/*
 * genetic_control.cpp
 *
 *  Created on: 18/05/2010
 *      Author: jeferson
 */

#include "genetic_control.h"
#include <time.h>
#include <iostream>
#include <numeric>

GeneticControl::GeneticControl( std::tr1::shared_ptr<scenario::Scenario> scenario)
:AI::GenericAI(scenario), _genePos(0),  _epoch(0), _move(false), _path(0)
{
	_population.reserve(_populationSize);
}

GeneticControl::~GeneticControl() {
}

int GeneticControl::findPath(std::vector<DirectionE>& path, const Coord& origem, const Coord& destino) {
	_dest = destino;
	_orig = origem;
	this->epoch();

	std::bitset<2> gene;
	std::bitset<_gene> bestChromosome; // = _bestGenome.getPath(i);
	int step = 0;
	for (unsigned int i = 0; i < _bestGenome.acumPathSize(); i++) {
		bestChromosome = _bestGenome.getPath(i);
		for (unsigned int j = 0; j < _gene; j += 2) {
			gene.set(0, bestChromosome[j]);
			gene.set(1, bestChromosome[j + 1]);
			path.push_back(this->direction(gene));
			step++;
		}
	}
	this->bestPath(path);
	return step;
}

void GeneticControl::bestPath(std::vector<DirectionE>& path) {
	DirectionE dir1, dir2;
	for (unsigned int i = 0; i < path.size() -1; i++) {
		dir1 = path[i];
		dir2 = path[i];
		if (	((dir1 == LEFT) && (dir2 == RIGHT)) ||
				((dir1 == RIGHT) && (dir2 == LEFT)) ||
				((dir1 == UP) && (dir2 == DOWN))	||
				((dir1 == DOWN) && (dir2 == UP))) {
			path.erase(path.begin() + (i + 1));
		}
	}
}

void GeneticControl::checkPath(Genome<_gene>& genome) {
	std::bitset<2> gene;
	std::bitset<_gene> chromo;
	std::tr1::shared_ptr<character::Character> man(new character::Character(genome.atPosition()));
	unsigned int step = 0;
	chromo = genome.getPath(genome.acumPathSize() - 1);

	for (unsigned int i = 0; i < _gene; i += 2) {
		gene.set(0, chromo[i]);
		gene.set(1, chromo[i + 1]);
		Coord dirCoord = Transform::dirToCoord(this->direction(gene));
		std::tr1::shared_ptr<scenario::Cell> currentCell = _scenario->cell(man->position());

		Coord nextPosition(currentCell->coordinate() + dirCoord);
		std::tr1::shared_ptr<scenario::Cell> nextCell = _scenario->cell(nextPosition.x, nextPosition.y);
		if (nextCell->pass()) {
			man->position(man->position() + Transform::coordToVec(dirCoord));
		}

		step++;
		if (this->left(man->position())) {
			genome.fitness(this->fitness(man->position()));
			genome.step(genome.step() + step);
			genome.atPosition(man->position());
			genome.left(true);
			return;
		}
	}

	genome.fitness(this->fitness(man->position()));
	genome.step(genome.step() + step);
	genome.atPosition(man->position());
}

DirectionE GeneticControl::direction(std::bitset<2> gene) {
	if (gene[0] == 0) { //up or dow
		if (gene[1] == 0) {
			return UP;
		}
		return DOWN;
	} else {
		if (gene[1] == 0) {
			return LEFT;
		}
	}
	return RIGHT;
}

void GeneticControl::epoch() {
	_epoch++;

	_genePos = 0;
	_move = false;
	_path = 0;

	_population.clear();
	for (unsigned int i = 0; i < _populationSize; i++) {
		_population.push_back(Genome<_gene>(Transform::coordToVec(_orig)));
	}
	for (unsigned int i = 0; i < _populationSize; i++) {
		_population[i].addChromo(_population[i].chromossome());
	}
	int generation = 0;

	do {
		this->updatePopulation();
		if (this->checkLeft()) {
			this->findBestGenome();
			_move = true;
			return;
		}
		std::vector<Genome<_gene> > babies, pop;
		Genome<_gene> mum, dad;

		pop = _population;

		unsigned int i = 0;
		while(pop.size() > 0) {
			babies.push_back(Genome<_gene>());
			babies.push_back(Genome<_gene>());

			//sorteia
			int roulette = this->rouletteWheelSelection(pop);
			mum = pop[roulette];
			pop.erase(pop.begin() + roulette);
			roulette = this->rouletteWheelSelection(pop);
			dad = pop[roulette];
			pop.erase(pop.begin() + roulette);

//			this->crossoverSinglePoint(mum, dad, babies[i], babies[i + 1]);
			this->crossoverTwoPoint(mum, dad, babies[i], babies[i + 1]);
//			this->crossoverMultPoint(mum, dad, babies[i], babies[i + 1]);
			this->mutation(babies[i]);
			this->mutation(babies[i + 1]);
			i += 2;
		}
		_population = babies;
		generation++;
	} while(generation < _maxGeneration);

	this->findBestGenome();
	_move = true;
}

int GeneticControl::rouletteWheelSelection(std::vector<Genome<_gene> > pop) {
	if (pop.size() == 1) {
		return 0;
	}
	int sum = 0;
	for (std::vector<Genome<_gene> >::iterator it = pop.begin(); it != pop.end(); it++) {
		sum += ((int) ((*it).fitness()));
	}

	double probabilities[pop.size()];

	int prob = 0;
	for (unsigned int i = 0; i < pop.size(); i++) {
		prob = (((double)pop[i].fitness() / (double)sum) * 100000);
		probabilities[i] = prob / 1000; //muitos erros numericos!!!
	}
	std::vector<double> cumulative;
	std::partial_sum(&probabilities[0], &probabilities[0] + pop.size(), std::back_inserter(cumulative));
	boost::uniform_real<> dist(0, cumulative.back());
	boost::variate_generator<boost::mt19937&, boost::uniform_real<> > die(gen, dist);

	return (std::lower_bound(cumulative.begin(), cumulative.end(), die())- cumulative.begin());
}

void GeneticControl::crossoverSinglePoint(const Genome<_gene>& mum, const Genome<_gene>& dad, Genome<_gene>& baby1, Genome<_gene>& baby2) {
	if (Random::getInstance()->roll(0, 100) > _crossoverRate) {
		baby1 = mum;
		baby1.addChromo(mum.chromossome());
		baby2 = dad;
		baby2.addChromo(dad.chromossome());
		return;
	}

	baby1 = mum;
	baby2 = dad;

	unsigned int crossPoss = Random::getInstance()->roll(0, _gene -1);

	std::bitset<_gene> chromoBaby1, chromoBaby2, chromoMum, chromoDad;
	chromoBaby1 = mum.chromossome();
	chromoBaby2 = dad.chromossome();
	chromoMum = mum.chromossome();
	chromoDad = dad.chromossome();

	for (unsigned int i = 0; i < crossPoss; i++) {
		chromoBaby1.set(i, chromoDad[i]);
		chromoBaby2.set(i, chromoMum[i]);
	}
	baby1.chromossome(chromoBaby1);
	baby1.addChromo(chromoBaby1);
	baby2.chromossome(chromoBaby2);
	baby2.addChromo(chromoBaby2);

}

void GeneticControl::crossoverTwoPoint(const Genome<_gene>& mum, const Genome<_gene>& dad, Genome<_gene>& baby1, Genome<_gene>& baby2) {
	if (Random::getInstance()->roll(0, 100) > _crossoverRate) {
		baby1 = mum;
		baby1.addChromo(mum.chromossome());
		baby2 = dad;
		baby2.addChromo(dad.chromossome());
		return;
	}

	baby1 = mum;
	baby2 = dad;

	unsigned int crossPoint1, crossPoint2;
	crossPoint1 = Random::getInstance()->roll(0, _gene - 2);
	crossPoint2 = Random::getInstance()->roll(crossPoint1 + 1, _gene - 1);

	std::bitset<_gene> chromoBaby1, chromoBaby2, chromoMum, chromoDad;
	chromoBaby1 = mum.chromossome();
	chromoBaby2 = dad.chromossome();
	chromoMum = mum.chromossome();
	chromoDad = dad.chromossome();

	for (unsigned int i = crossPoint1; i < crossPoint2; i++) {
		chromoBaby1.set(i, chromoDad[i]);
		chromoBaby2.set(i, chromoMum[i]);
	}

	baby1.chromossome(chromoBaby1);
	baby1.addChromo(chromoBaby1);
	baby2.chromossome(chromoBaby2);
	baby2.addChromo(chromoBaby2);
}

void GeneticControl::crossoverMultPoint(const Genome<_gene>& mum, const Genome<_gene>& dad, Genome<_gene>& baby1, Genome<_gene>& baby2) {
	int rateSwap = 75; //50%

	if (Random::getInstance()->roll(0, 100) > _crossoverRate) {
		baby1 = mum;
		baby1.addChromo(mum.chromossome());
		baby2 = dad;
		baby2.addChromo(dad.chromossome());
		return;
	}

	baby1 = mum;
	baby2 = dad;

	std::bitset<_gene> chromoBaby1, chromoBaby2, chromoMum, chromoDad;
	chromoBaby1 = mum.chromossome();
	chromoBaby2 = dad.chromossome();
	chromoMum = mum.chromossome();
	chromoDad = dad.chromossome();

	for (unsigned int i = 0; i < _gene; i++) {
		if (Random::getInstance()->roll(0, 100) < rateSwap) {
			chromoBaby1.set(i, chromoDad[i]);
			chromoBaby2.set(i, chromoMum[i]);
		}
	}
	baby1.chromossome(chromoBaby1);
	baby1.addChromo(chromoBaby1);
	baby2.chromossome(chromoBaby2);
	baby2.addChromo(chromoBaby2);
}

void GeneticControl::mutation(Genome<_gene>& baby) {
	std::bitset<_gene> babyChromo = baby.chromossome();
	for (unsigned int i = 0; i < _gene; i++ ) {
		if (Random::getInstance()->roll(0, 1000) <= _mutationRate) {
			babyChromo.flip(i);
		}
	}
	baby.chromossome(babyChromo);
}

void GeneticControl::updatePopulation() {
	for (std::vector<Genome<_gene> >::iterator it = _population.begin(); it != _population.end(); it++) {
		this->checkPath((*it));
	}
	this->explicitFitnessSharing();
}

bool GeneticControl::checkLeft() {
	for (std::vector<Genome<_gene> >::iterator it = _population.begin(); it != _population.end(); it++) {
		if ((*it).left()) {
			return true;
		}
	}
	return false;
}

void GeneticControl::findBestGenome() {
	unsigned int step = 999999;
	Genome<_gene> genome;
	std::vector<Genome<_gene> > test;

	for (std::vector<Genome<_gene> >::iterator it = _population.begin(); it != _population.end(); it++) {
		if (((*it).step() < step)) {
			step = (*it).step();
			test.push_back((*it));
			genome = (*it);
		}
	}
	_bestGenome = genome;
}

void GeneticControl::resetNiche() {
	for (unsigned int i = 0; i < _gene; i++) {
		_niches[i] = 0;
	}
}

void GeneticControl::explicitFitnessSharing() {
	std::bitset<_gene> sample = _population[0].chromossome();
	std::bitset<_gene> chromo;
	this->resetNiche();
	for (std::vector<Genome<_gene> >::iterator it = _population.begin(); it != _population.end(); it++) {
		chromo = (*it).chromossome();
		unsigned int niche = 0;
		for (unsigned int i = 0; i < _gene; i++) {
			if (sample[i] == chromo[i]) {
				niche++;
			}
		}
		(*it).niche(niche);

		if (niche > 0) {
			_niches[niche - 1]++;
		}
	} //end for
//
	int index = 0;
	for (unsigned int i = 0; i < _population.size(); i++) {
		index = _population[i].niche() - 1;
		if (index > 0) {
			_population[i].fitness(_population[i].fitness() / _niches[index]);
		}
	}

}

bool GeneticControl::left(Vector position) {
	return (_dest == Coord(position.x / 30, position.y / 30));
}

double GeneticControl::fitness(Vector position) {
	Coord exit = _scenario->exit();
	Vector dist = Transform::coordToVec(exit);
	return 1.0 /(double) abs(abs(dist.x) + abs(dist.y) + 1.0);
}
