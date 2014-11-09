/*
 * repulse_behaviour.h
 *
 *  Created on: 24/05/2010
 *      Author: zce
 */

#ifndef REPULSE_BEHAVIOUR_H_
#define REPULSE_BEHAVIOUR_H_

#include "behaviour.h"

namespace character {

class RepulseBehaviour: public character::Behaviour {
public:
	RepulseBehaviour(std::tr1::shared_ptr<Entity> target,
			std::tr1::shared_ptr<Entity> evilGhost);
	virtual ~RepulseBehaviour();

	DirectionE nextMove(const Coord& currentPosition, std::tr1::shared_ptr<scenario::Scenario> scenario);

private:
	std::tr1::shared_ptr<Entity> _target;
	std::tr1::shared_ptr<Entity> _evilGhost;
};

}

#endif /* REPULSE_BEHAVIOUR_H_ */
