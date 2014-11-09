/*
 * follow_behaviour_genetic.h
 *
 *  Created on: 24/05/2010
 *      Author: jeferson
 */

#ifndef FOLLOW_BEHAVIOUR_GENETIC_H_
#define FOLLOW_BEHAVIOUR_GENETIC_H_

#include "Util/util.h"
#include "behaviour.h"

namespace character {

class FollowBehaviourGenetic : public Behaviour{
public:
	FollowBehaviourGenetic(std::tr1::shared_ptr<Entity> target);
	virtual ~FollowBehaviourGenetic();

	DirectionE nextMove(const Coord& currentPosition, std::tr1::shared_ptr<scenario::Scenario> scenario);

private:
	std::tr1::shared_ptr<Entity> _target;

};

}

#endif /* FOLLOW_BEHAVIOUR_GENETIC_H_ */
