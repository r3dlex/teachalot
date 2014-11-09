/*
 * follow_behaviour_genetic.cpp
 *
 *  Created on: 24/05/2010
 *      Author: jeferson
 */

#include "follow_behaviour_genetic.h"
#include "AI/Genetic/genetic_control.h"

namespace character {

FollowBehaviourGenetic::FollowBehaviourGenetic(std::tr1::shared_ptr<Entity> target)
	: _target(target) {

}

FollowBehaviourGenetic::~FollowBehaviourGenetic() {
}

DirectionE FollowBehaviourGenetic::nextMove(const Coord& currentPosition, std::tr1::shared_ptr<scenario::Scenario> scenario) {
	static int callCount = 1;
	callCount++;

	Coord dest(_target->position().x / 30, _target->position().y / 30);

	std::vector<DirectionE> path;
	GeneticControl pathfinder(scenario);
//	AI::AStar pathfinder(scenario);
	pathfinder.findPath(path, currentPosition, dest);

	DirectionE d = path[0];
//	Coord delta = path[1] - path[0];
//
//	DirectionE d = STAY;
//
//	if (delta.x == -1) d = LEFT;
//	else if (delta.x == 1) d = RIGHT;
//	else if (delta.y == -1) d = UP;
//	else if (delta.y == 1) d = DOWN;

	if (callCount % 10 == 0) {
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
