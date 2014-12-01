/*
 * scenario1.cpp
 *
 *  Created on: 07/05/2010
 *      Author: jeferson
 */

#include "scenario1.h"

namespace scenario {

Scenario1::Scenario1(unsigned int w, unsigned int h)
:Scenario(w, h)
{
	this->scenarioMount();


}

Scenario1::~Scenario1() {

}

void Scenario1::scenarioMount() {
	for(unsigned int i = 0; i < _sizeW; i++) {
		for (unsigned int j = 0; j < _sizeH; j++) {
			this->cell(0, j)->type(WALL);
			this->cell(this->sizeW() - 1, j)->type(WALL);
			this->cell(i, 0)->type(WALL);
			this->cell(i, this->sizeH() - 1)->type(WALL);

			if ((i == 5) && (j > 4)) {
				this->cell(i, j)->type(WALL);
			}
		}
	}

	_exit = Coord(10, 14);
	this->cell(_exit.x, _exit.y)->type(EXIT);

}


}  // namespace scenario

