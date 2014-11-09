/*
 * genetic_control.h
 *
 *  Created on: 18/05/2010
 *      Author: jeferson
 */

#ifndef GENETIC_CONTROL_H_
#define GENETIC_CONTROL_H_

#include <bitset>
#include <cstdlib>
#include <tr1/memory>
#include <vector>
#include <boost/random.hpp>
#include "Character/character.h"
#include "world_simulation.h"
#include "Scenario/scenario.h"
#include "genome.h"
#include "AI/generic_ai.h"

class GeneticControl : public AI::GenericAI {
public:
	GeneticControl(/*std::tr1::shared_ptr<character::Character> character,*/
			/*std::tr1::shared_ptr<WorldSimulation> world,*/ /*Coord mission,*/ std::tr1::shared_ptr<scenario::Scenario> scenario);
	virtual ~GeneticControl();

//	void move();
//	void moveOne();

	virtual int findPath(std::vector<DirectionE>& path, const Coord& origem, const Coord& destino);



protected:
	static unsigned int const _gene = 16;
	static unsigned int const _populationSize = 180; //numero par
	static int const _crossoverRate = 70; // [0-100]     70 == 70%
	static int const _mutationRate = 6; //[0 - 1000]     1 == 0.1%
	static int const _maxGeneration = 20;
//	std::tr1::shared_ptr<character::Character> _char;
//	std::tr1::shared_ptr<WorldSimulation> _world;
	unsigned int _genePos;
	int _epoch;
	Genome<_gene> _bestGenome;
	std::vector<Genome<_gene> > _population;
	bool _move;
	boost::mt19937 gen;
	std::vector<double> _memory;
//	Vector _initialPosition;
	unsigned int _niches[_gene];
	unsigned int _path;

	Coord _orig;
	Coord _dest;

//	Coord _mission;

private:

	DirectionE direction(std::bitset<2> gene);
	void epoch();
	int rouletteWheelSelection(std::vector<Genome<_gene> > pop);
	void crossoverSinglePoint(const Genome<_gene>& mum, const Genome<_gene>& dad, Genome<_gene>& baby1, Genome<_gene>& baby2);
	void crossoverTwoPoint(const Genome<_gene>& mum, const Genome<_gene>& dad, Genome<_gene>& baby1, Genome<_gene>& baby2);
	void crossoverMultPoint(const Genome<_gene>& mum, const Genome<_gene>& dad, Genome<_gene>& baby1, Genome<_gene>& baby2);
	void mutation(Genome<_gene>& baby);


	void checkPath(Genome<_gene>& genome);
	bool checkLeft();
	void updatePopulation();
	void findBestGenome();

	void resetNiche();
	void explicitFitnessSharing();
	bool left(Vector position);
	void bestPath(std::vector<DirectionE>& path);
	double fitness(Vector position);
};

#endif /* GENETIC_CONTROL_H_ */
