/*
 * automatic_character.cpp
 *
 *  Created on: 22/05/2010
 *      Author: jeferson
 */

#include "automatic_character.h"

#include <SDL/SDL.h>

namespace AI {

AutomaticCharacter::AutomaticCharacter(Vector position,
		std::tr1::shared_ptr<AI::GenericAI> ai,
		std::tr1::shared_ptr<Entity> follow)
:character::Character(position), _ai(ai), _follow(follow), _indexPath(0), _on(true)
{
	this->resetAI();
}

AutomaticCharacter::~AutomaticCharacter() {
}

DirectionE AutomaticCharacter::step() {
	if (!_on) return STAY;
	return _path[_indexPath];
}

void AutomaticCharacter::resetAI() {
	if (!_on) return;

	Coord orig = Transform::vecToCoord(_position);
	Coord dest = Transform::vecToCoord(_follow->position());

	_path.clear();
	_ai->findPath(_path, orig, dest);
}

bool AutomaticCharacter::endFollow() const {
	if (_position == _follow->position()) {
		return true;
	}
	return false;
}

bool AutomaticCharacter::on() const {
	return _on;
}

void AutomaticCharacter::on(bool stats) {
	_on = stats;
}

}



//void Aut
