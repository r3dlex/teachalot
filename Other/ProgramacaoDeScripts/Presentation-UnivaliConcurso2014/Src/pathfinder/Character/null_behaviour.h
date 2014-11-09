/*
 * null_behaviour.h
 *
 *  Created on: 24/05/2010
 *      Author: zce
 */

#ifndef NULL_BEHAVIOUR_H_
#define NULL_BEHAVIOUR_H_

#include "behaviour.h"

namespace character {

class NullBehaviour: public character::Behaviour {
public:
	NullBehaviour();
	virtual ~NullBehaviour();

	DirectionE nextMove(const Coord& currentPosition, std::tr1::shared_ptr<scenario::Scenario> scenario) {
		return STAY;
	}
};

}

#endif /* NULL_BEHAVIOUR_H_ */
