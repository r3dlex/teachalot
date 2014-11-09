/*
 * ghost_character.h
 *
 *  Created on: 23/05/2010
 *      Author: zce
 */

#ifndef GHOST_CHARACTER_H_
#define GHOST_CHARACTER_H_

#include "character.h"
#include "behaviour.h"
#include "Util/util.h"
namespace character {

class GhostCharacter: public Character {
public:
	GhostCharacter(const Vector& position, std::tr1::shared_ptr<Behaviour> behaviour);
	virtual ~GhostCharacter();

	std::tr1::shared_ptr<Behaviour> behaviour() { return _behaviour; }

	void behaviour(std::tr1::shared_ptr<Behaviour> behaviour) {
		_behaviour = behaviour;
	}

	DirectionE nextMove(std::tr1::shared_ptr<scenario::Scenario> scenario) const;

private:
	std::tr1::shared_ptr<Behaviour> _behaviour;
};

}

#endif /* GHOST_CHARACTER_H_ */
