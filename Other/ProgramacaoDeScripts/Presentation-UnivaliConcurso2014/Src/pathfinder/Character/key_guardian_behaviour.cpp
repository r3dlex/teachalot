/*
 * follow_behaviour.cpp
 *
 *  Created on: 23/05/2010
 *      Author: zce
 */

#include "key_guardian_behaviour.h"

#include "AI/a_star.h"

#include <iostream>

namespace character {

KeyGuardianBehaviour::KeyGuardianBehaviour(std::tr1::shared_ptr<Entity> key,
		std::tr1::shared_ptr<Entity> hero, std::tr1::shared_ptr<Entity> scared)
	: _key(key), _hero(hero), _scared(scared) {
}

KeyGuardianBehaviour::~KeyGuardianBehaviour() {
}

DirectionE KeyGuardianBehaviour::nextMove(const Coord& currentPosition, std::tr1::shared_ptr<scenario::Scenario> scenario) {
	std::vector<Coord> path;
	AI::AStar pathfinder(scenario);

	if (_key->position() == _hero->position()) {
		Coord heroOrig = Transform::vecToCoord(_hero->position());
		Coord heroDest = scenario->exit();

		pathfinder.findPath(path, heroOrig, heroDest);

		std::vector<Coord>::iterator it = std::find(path.begin(), path.end(), currentPosition);
		if (it != path.end()) {
			/* I am on hero's path,  */
			Coord nextMove = *--it;
			path.clear();
			path.push_back(currentPosition);
			path.push_back(nextMove);
		} else if (path.size() > 8) {
			/* I will intercept hero's path */
			Coord dest = path[7];
			path.clear();
			pathfinder.findPath(path, currentPosition, dest);
		} else {
			/* Hero is too close, just chase */
			path.clear();
		}
	}

	if (path.empty()) {
		Coord dest = Transform::vecToCoord(_key->position());
		pathfinder.findPath(path, currentPosition, dest);
	}

	Coord delta = path[1] - path[0];
	DirectionE result = Transform::coordToDir(delta);

	/* Next step is getting the key */
	if (path.size() == 2) {
		Vector deltaKeyHero = _key->position() - _hero->position();
		double distHeroKey = deltaKeyHero.dot(deltaKeyHero);
		Vector deltaHeroScared = _hero->position() - _scared->position();
		double distHeroScared = deltaHeroScared.dot(deltaHeroScared);

		if (distHeroScared < distHeroKey) {
			result = STAY;
		}
	}

	return result;
}

}
