/*
 * scenario.cpp
 *
 *  Created on: 07/05/2010
 *      Author: jeferson
 */

#include "scenario.h"

#include <iostream>
#include <fstream>

namespace scenario {

Coord Scenario::_exit, Scenario::_start, Scenario::_key;

Scenario::Scenario(unsigned int sizeW, unsigned int sizeH)
:_sizeW(sizeW), _sizeH(sizeH)
{
	_cell.resize(_sizeW);
	for(unsigned int i = 0; i < _sizeW; i++) {
		_cell[i].resize(_sizeH);
		for (unsigned int j = 0; j < _sizeH; j++) {
			_cell[i][j].reset(new Cell(GROUND, Coord(i, j)));
		}
	}
}

Scenario::~Scenario() {
}

Coord Scenario::exit() const {
	return _exit;
}

Coord Scenario::start() const {
	return _start;
}

Coord Scenario::key() const {
	return _key;
}

unsigned int Scenario::sizeW() const {
	return _sizeW;
}

unsigned int Scenario::sizeH() const {
	return _sizeH;
}

std::tr1::shared_ptr<Cell> Scenario::cell(unsigned int x, unsigned int y) {
	if ((x < _sizeW) && (y < _sizeH)) {
		return _cell[x][y];
	}
	std::tr1::shared_ptr<Cell> cell;
	return cell;
}

std::tr1::shared_ptr<Cell> Scenario::cell(const Vector& position) {
	std::tr1::shared_ptr<Cell> cell;
	if ((position.x < 0) || (position.y < 0)) {
		return cell;  //null
	}

	//TODO: 30 é tamanho da celula, mudar??
	return this->cell((unsigned int)(position.x / 30), (unsigned int)(position.y / 30));
}

std::tr1::shared_ptr<Scenario> Scenario::loadFromFile(const std::string& filename) {
	unsigned int width, height;
	std::ifstream in(filename.c_str());
	in >> width >> height >> std::ws;

	std::tr1::shared_ptr<Scenario> scenario(new Scenario(width, height));

	for (unsigned int i = 0; i < height; ++i) {
		std::string line;
		getline(in, line);
		for (unsigned int j = 0; j < width && j < line.size(); ++j) {
			if (line[j] == 'x') {
				scenario->cell(j, i)->type(WALL);
			} else if (line[j] == 'e') {
				_exit = Coord(j, i);
				scenario->cell(j, i)->type(EXIT);
			} else if (line[j]  == 's') {
				_start = Coord(j, i);
			} else if (line[j] == 'k') {
				_key = Coord(j, i);
				scenario->cell(j, i)->type(KEYOFF);
			}
		}
	}

	return scenario;
}


}  // namespace scenario

