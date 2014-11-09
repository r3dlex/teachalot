/*
 * sprite.cpp
 *
 *  Created on: 08/05/2010
 *      Author: jeferson
 */

#include "sprite.h"

Sprite::Sprite(Vector position)
:_position(position)
{

}

Sprite::~Sprite() {
}

SDL_Surface* Sprite::sprite() {
	return _sprite;
}

Vector Sprite::position() {
	return _position;
}
