/*
 * sprite.h
 *
 *  Created on: 08/05/2010
 *      Author: jeferson
 */

#ifndef SPRITE_H_
#define SPRITE_H_

#include <SDL/SDL.h>
#include "Util/util.h"

class Sprite {
public:
	Sprite(Vector position);
	virtual ~Sprite();

	SDL_Surface* sprite();
	virtual Vector position();

	virtual void update() {}

	virtual void direction(DirectionE dir) {
		_direction = dir;
	}

	virtual DirectionE direction() const {
		return _direction;
	}

protected:
	Vector _position;
	SDL_Surface* _sprite;
	DirectionE _direction;

};

#endif /* SPRITE_H_ */
