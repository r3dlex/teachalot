/*
 * follow_behaviour.cpp
 *
 *  Created on: 23/05/2010
 *      Author: zce
 */

#include "follow_behaviour.h"

#include "AI/a_star.h"

namespace character {

FollowBehaviour::FollowBehaviour(std::tr1::shared_ptr<Entity> target)
	: _target(target) {
}

FollowBehaviour::~FollowBehaviour() {
}

DirectionE FollowBehaviour::nextMove(const Coord& currentPosition, std::tr1::shared_ptr<scenario::Scenario> scenario) {
	if (!_target) return STAY;

	static int callCount = 0;
	callCount++;

	Coord dest(_target->position().x / 30, _target->position().y / 30);

	std::vector<Coord> path;
	AI::AStar pathfinder(scenario);
	pathfinder.findPath(path, currentPosition, dest);

	Coord delta = path[1] - path[0];

	DirectionE d = STAY;

	if (delta.x == -1) d = LEFT;
	else if (delta.x == 1) d = RIGHT;
	else if (delta.y == -1) d = UP;
	else if (delta.y == 1) d = DOWN;

	if (callCount % 3 == 0) {
		DirectionE possibleDirections[4];
		int directionCount = 0;

		if (scenario->cell(currentPosition.x-1, currentPosition.y)->pass()) {
			possibleDirections[directionCount++] = LEFT;
		}
		if (scenario->cell(currentPosition.x+1, currentPosition.y)->pass()) {
			possibleDirections[directionCount++] = RIGHT;
		}
		if (scenario->cell(currentPosition.x, currentPosition.y-1)->pass()) {
			possibleDirections[directionCount++] = UP;
		}
		if (scenario->cell(currentPosition.x, currentPosition.y+1)->pass()) {
			possibleDirections[directionCount++] = DOWN;
		}

		d = possibleDirections[Random::getInstance()->roll(0, directionCount)];
	}

	return d;
}

}
