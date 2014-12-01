/*
 * ghost_character.cpp
 *
 *  Created on: 23/05/2010
 *      Author: zce
 */

#include "ghost_character.h"

namespace character {

GhostCharacter::GhostCharacter(const Vector& position, std::tr1::shared_ptr<Behaviour> behaviour)
	: Character(position), _behaviour(behaviour) {

}

GhostCharacter::~GhostCharacter() {
}

DirectionE GhostCharacter::nextMove(std::tr1::shared_ptr<scenario::Scenario> scenario) const {
	Coord orig(position().x/30, position().y/30);
	return _behaviour->nextMove(orig, scenario);
}

}
