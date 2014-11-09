/*
 * world_simulation.h
 *
 *  Created on: 17/05/2010
 *      Author: jeferson
 */

#ifndef WORLD_SIMULATION_H_
#define WORLD_SIMULATION_H_

#include <tr1/memory>
#include <list>
#include "Scenario/scenario.h"
#include "Character/character.h"
#include "AI/automatic_character.h"

#include <map>

class WorldSimulation {
public:
	typedef std::list<std::tr1::shared_ptr<character::Character> > CharList;
	typedef CharList::iterator CharListIt;

	typedef std::list<std::tr1::shared_ptr<AI::AutomaticCharacter> > BotList;
	typedef BotList::iterator BotListIt;



	WorldSimulation(std::tr1::shared_ptr<scenario::Scenario> scenario);
	virtual ~WorldSimulation();

	void scenario(std::tr1::shared_ptr<scenario::Scenario> scenario);
	std::tr1::shared_ptr<scenario::Scenario> scenario();

	void beginMovement(unsigned int time, std::tr1::shared_ptr<character::Character> character, DirectionE direction);
	void updateAnimation(unsigned int time);
	void jump(const std::tr1::shared_ptr<character::Character> character, DirectionE direction);
	bool moving(std::tr1::shared_ptr<character::Character> character);


protected:
	std::tr1::shared_ptr<scenario::Scenario> _scenario;
	static float const _movementDuration = 400;

	std::map<std::tr1::shared_ptr<character::Character>, unsigned int> _movementTimeStarted;
	std::map<std::tr1::shared_ptr<character::Character>, float> _movementLastTime;
	std::map<std::tr1::shared_ptr<character::Character>, DirectionE> _destination;
};

#endif /* WORLD_SIMULATION_H_ */
