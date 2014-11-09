/*
 * world_sSimulation.cpp
 *
 *  Created on: 17/05/2010
 *      Author: jeferson
 */

#include "world_simulation.h"
#include "Util/util.h"
#include <cstdlib>

#include <iostream>

WorldSimulation::WorldSimulation(std::tr1::shared_ptr<scenario::Scenario> scenario)
:_scenario(scenario)
{
}

WorldSimulation::~WorldSimulation() {
}

void WorldSimulation::scenario(std::tr1::shared_ptr<scenario::Scenario> scenario) {
	_scenario = scenario;
}

std::tr1::shared_ptr<scenario::Scenario> WorldSimulation::scenario() {
	return _scenario;
}

void WorldSimulation::beginMovement(unsigned int time, const std::tr1::shared_ptr<character::Character> character, DirectionE direction) {
	if (!moving(character)) {
		Coord dirCoord = Transform::dirToCoord(direction);
		std::tr1::shared_ptr<scenario::Cell> currentCell = _scenario->cell(character->position());

		Coord nextPosition(currentCell->coordinate() + dirCoord);
		std::tr1::shared_ptr<scenario::Cell> nextCell = _scenario->cell(nextPosition.x, nextPosition.y);

		if (nextCell->pass()) {
			_movementTimeStarted[character] = time;
			_destination[character] = direction;
		}
	}
}

void WorldSimulation::updateAnimation(unsigned int time) {
	for (std::map<std::tr1::shared_ptr<character::Character>, unsigned int>::iterator it = _movementTimeStarted.begin();
			it != _movementTimeStarted.end();
			++it) {
		std::tr1::shared_ptr<character::Character> character = it->first;
		if (moving(character)) {
			float t = (time - _movementTimeStarted[character]) / _movementDuration;

			DirectionE direction = _destination[character];

			Vector dir = Transform::coordToVec(Transform::dirToCoord(direction));
			Vector orig = character->position();

			if (t > 0.1) {
				if (_movementLastTime[character] < 0.1) {
					Coord step = Transform::dirToCoord(direction);
					character->position(character->position() + Transform::coordToVec(step));
				}
				orig = character->position() - dir;
			}

			if (t > 1.0) t = 1.0;

			Vector place(orig + dir * t);
			character->spritePosition(place);

			_movementLastTime[character] = t;

			if (t >= 1.0) {
				_movementTimeStarted[character] = 0;
			}
		} else if (!(character->position() == character->spritePosition())) {
			std::cout << "TELEPORT " << character->position().x << ", " << character->position().y << std::endl;
			std::cout << "  spritePos" << character->spritePosition().x << ", " << character->spritePosition().y << std::endl;
			std::cout << "  _movementLastTime " << _movementLastTime[character] << std::endl;
			character->spritePosition(character->position());
		}
	}
}

bool WorldSimulation::moving(std::tr1::shared_ptr<character::Character> character) {
	std::map<std::tr1::shared_ptr<character::Character>, unsigned int>::iterator it = _movementTimeStarted.find(character);
	if (it == _movementTimeStarted.end()) {
		return false;
	}
	if (it->second == 0) {
		return false;
	}

	return true;
}

void WorldSimulation::jump(const std::tr1::shared_ptr<character::Character> character, DirectionE direction) {
	if (direction == STAY) return;

	Vector dir = Transform::dirToVec(direction);
	Coord dirCoord = Coord(dir.x, dir.y);
	std::tr1::shared_ptr<scenario::Cell> currentCell = _scenario->cell(character->position());
	Coord nextPosition(currentCell->coordinate() + dirCoord);
	std::tr1::shared_ptr<scenario::Cell> nextCell = _scenario->cell(nextPosition.x, nextPosition.y);
	if (nextCell->pass()) {
		character->direction(direction);
		character->position(character->position() + (dir * 30) );
	}
}


