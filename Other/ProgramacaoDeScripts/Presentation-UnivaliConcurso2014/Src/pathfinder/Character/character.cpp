/*
 * character.cpp
 *
 *  Created on: 10/05/2010
 *      Author: jeferson
 */

#include "character.h"

#include <iostream>

namespace character {

Character::Character(Vector position)
:_position(position), _spritePosition(position), _direction(STAY)
{


}

Character::~Character() {
}

Vector Character::position() const {
	return _position;
}

void Character::position(Vector position) {
	_position = position;
}


Vector Character::spritePosition() const {
	return _spritePosition;
}

void Character::spritePosition(Vector position) {
	_spritePosition = position;
}

}
