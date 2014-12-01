/*
 * entity.h
 *
 *  Created on: 23/05/2010
 *      Author: zce
 */

#ifndef ENTITY_H_
#define ENTITY_H_

#include "Util/util.h"

class Entity {
public:
	virtual ~Entity() {}

	virtual Vector position() const = 0;

	virtual Vector spritePosition() const = 0;

	virtual DirectionE direction() const {
		return STAY;
	}
};

#endif /* ENTITY_H_ */
