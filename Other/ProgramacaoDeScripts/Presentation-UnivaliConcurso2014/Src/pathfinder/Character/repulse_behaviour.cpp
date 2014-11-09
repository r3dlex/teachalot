/*
 * repulse_behaviour.cpp
 *
 *  Created on: 24/05/2010
 *      Author: zce
 */

#include "repulse_behaviour.h"

#include "AI/a_star.h"
#include <cmath>

namespace character {

namespace {

struct DistanceFromTarget {
	DistanceFromTarget(std::tr1::shared_ptr<Entity> target,
			std::tr1::shared_ptr<Entity> protector)
		: _target(target), _protector(protector) {}

	float operator()(const Coord& pos) {
		Coord targetPos = Transform::vecToCoord(_target->position());
		Coord protectorPos = Transform::vecToCoord(_protector->position());
		Vector distTarget = Vector(pos.x, pos.y) - Vector(targetPos.x, targetPos.y);
		Vector distProtector = Vector(pos.x, pos.y) - Vector(protectorPos.x, protectorPos.y);
		return 10.0 / distTarget.dot(distTarget);
	}

private:
	std::tr1::shared_ptr<Entity> _target;
	std::tr1::shared_ptr<Entity> _protector;
};

}

RepulseBehaviour::RepulseBehaviour(std::tr1::shared_ptr<Entity> target,
		std::tr1::shared_ptr<Entity> evilGhost)
	: _target(target), _evilGhost(evilGhost) {
}

RepulseBehaviour::~RepulseBehaviour() {
}

DirectionE RepulseBehaviour::nextMove(const Coord& currentPosition, std::tr1::shared_ptr<scenario::Scenario> scenario) {
	if (!_target) return STAY;

	Coord targetCoord(_target->position().x / 30, _target->position().y / 30);

	int x, y;

	if (targetCoord.x < int(scenario->sizeW() / 2)) {
		x = scenario->sizeW() - 2;
	} else {
		x = 1;
	}

	if (targetCoord.y < int(scenario->sizeH() / 2)) {
		y = scenario->sizeH() - 2;
	} else {
		y = 1;
	}

	Coord dest(x, y);

	std::vector<Coord> path;
	AI::AStar pathfinder(scenario, DistanceFromTarget(_target, _evilGhost));
	pathfinder.findPath(path, currentPosition, dest);

	Coord delta = path[1] - path[0];

	DirectionE d = STAY;

	if (delta.x == -1) d = LEFT;
	else if (delta.x == 1) d = RIGHT;
	else if (delta.y == -1) d = UP;
	else if (delta.y == 1) d = DOWN;

	return d;
}

}
