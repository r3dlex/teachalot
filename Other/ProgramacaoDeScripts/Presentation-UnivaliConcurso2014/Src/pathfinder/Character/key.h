/*
 * key.h
 *
 *  Created on: 24/05/2010
 *      Author: zce
 */

#ifndef KEY_H_
#define KEY_H_

#include "entity.h"

namespace character {

class Key: public Entity {
public:
	Key(const Vector& position) : _position(position) {}
	virtual ~Key() {}

	Vector position() const { return _position; }

	Vector spritePosition() const { return _position; }

	void position(const Vector& pos) { _position = pos; }

private:
	Vector _position;
};

}

#endif /* KEY_H_ */
