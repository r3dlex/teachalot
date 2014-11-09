/*
 * character.h
 *
 *  Created on: 10/05/2010
 *      Author: jeferson
 */

#ifndef CHARACTER_H_
#define CHARACTER_H_

#include "entity.h"
#include "Character/charecter_type.h"
#include "Util/util.h"

namespace character {

class Character: public Entity {
public:
	Character(Vector position);
	virtual ~Character();

	Vector position() const;
	void position(Vector position);

	Vector spritePosition() const;
	void spritePosition(Vector position);

	DirectionE direction() const {
		return _direction;
	}

	void direction(DirectionE dir) {
		_direction = dir;
	}

protected:
	Vector _position;
	Vector _spritePosition;
	DirectionE _direction;
};

}

#endif /* CHARACTER_H_ */
