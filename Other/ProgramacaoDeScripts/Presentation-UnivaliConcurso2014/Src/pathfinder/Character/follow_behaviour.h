/*
 * follow_behaviour.h
 *
 *  Created on: 23/05/2010
 *      Author: zce
 */

#ifndef FOLLOW_BEHAVIOUR_H_
#define FOLLOW_BEHAVIOUR_H_

#include "behaviour.h"
#include "Util/util.h"

namespace character {

class FollowBehaviour: public Behaviour {
public:
	FollowBehaviour(std::tr1::shared_ptr<Entity> target);
	virtual ~FollowBehaviour();

	DirectionE nextMove(const Coord& currentPosition, std::tr1::shared_ptr<scenario::Scenario> scenario);

private:
	std::tr1::shared_ptr<Entity> _target;
};

}

#endif /* FOLLOW_BEHAVIOUR_H_ */
