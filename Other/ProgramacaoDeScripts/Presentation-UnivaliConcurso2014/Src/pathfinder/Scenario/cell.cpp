/*
 * cell.cpp
 *
 *  Created on: 07/05/2010
 *      Author: jeferson
 */

#include "cell.h"

namespace scenario {

Cell::Cell(ImageE type, Coord position)
:_type (type), _position(position), _weight(0)
{
	this->type(type);

}

Cell::~Cell() {

}

bool Cell::pass() const {
	return _pass;
}

void Cell::type(ImageE type) {
	_type = type;
	if (type == WALL) {
		_pass = false;
	} else {
		_pass = true;
	}
}

ImageE Cell::type() const {
	return _type;
}

void Cell::position(Coord position) {
	_position = position;
}

Coord Cell::coordinate() const {
	return _position;
}

int Cell::weight() const {
	return _weight;
}

void Cell::weight(int w) {
	_weight = w;
}

}  // namespace scenario

