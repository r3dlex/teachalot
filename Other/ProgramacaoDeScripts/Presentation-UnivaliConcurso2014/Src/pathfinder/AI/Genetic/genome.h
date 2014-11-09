/*
 * genome.h
 *
 *  Created on: 18/05/2010
 *      Author: jeferson
 */

#ifndef GENOME_H_
#define GENOME_H_

#include <bitset>
#include <cstdlib>
#include <vector>
#include <time.h>
#include "Util/util.h"

#include <iostream>

template <unsigned int geneSize >
class Genome {
public:
	Genome(Vector position = Vector(0, 0))
	:_fitness(0.0), _step(0), _left(false), _atPosition(position), _nicheID(0)
	{
		this->initChromo();
	}

	virtual ~Genome(){}

	std::bitset<geneSize> chromossome() const {
		return _chromossome;
	}

	void chromossome(std::bitset<geneSize> chromo) {
		_chromossome = chromo;
	}

	void atPosition(Vector pos) {
		_atPosition = pos;
	}

	Vector atPosition() const {
		return _atPosition;
	}

	void fitness(double fit) {
		_fitness = fit * 1000;
	}

	double fitness() const {
		return _fitness;
	}

	void addChromo(std::bitset<geneSize> chromo) {
		_acumPath.push_back(chromo);
	}

	std::bitset<geneSize> getPath(unsigned int i) {
		return _acumPath[i];
	}

	unsigned int acumPathSize() const {
		return _acumPath.size();
	}

	void step(unsigned int s) {
		_step = s;
	}

	unsigned int step() const {
		return _step;
	}

	bool left() const {
		return _left;
	}

	void left(bool l) {
		_left = l;
	}

	void niche(unsigned int n) {
		_nicheID = n;
	}

	unsigned int niche() const {
		return _nicheID;
	}


private:
	void healthChromo() {
		std::bitset<2> dir1, dir2;
		for (unsigned int i = 0; i < geneSize - 2; i += 2) {
			dir1.set(0, _chromossome[i]);
			dir1.set(1, _chromossome[i + 1]);
			dir2.set(0, _chromossome[i + 2]);
			dir2.set(1, _chromossome[i + 3]);

			// 00 up, 01 down
			// 10 left, 11 down

			if ((dir1[1] == dir2[1]) && (dir1[0] != dir2[0])) {
//				std::cout << "i " << i << std::endl;
//				std::cout << "dir 1 " << dir1 << std::endl;
//				std::cout << "dir 2 " << dir2 << std::endl;
				dir2.flip(0);
			}
			_chromossome[i + 2] = dir2[0];
		}
	}

	void initChromo() {
		for (unsigned int i = 0; i < geneSize; i++) {
			_chromossome.set(i, Random::getInstance()->roll(0,1)); //0 or 1
		}
//		std::cout << "antes: " << _chromossome << std::endl;
//		this->healthChromo();
//		std::cout << "dpois: " << _chromossome << std::endl;
	}



protected:
	std::bitset< geneSize > _chromossome;
	std::vector<std::bitset<geneSize> > _acumPath;
	double _fitness;
	unsigned int _step;
	bool _left;
	Vector _atPosition;
	unsigned int _nicheID;

};

#endif /* GENOME_H_ */
