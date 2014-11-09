/*
 * behaviour.h
 *
 *  Created on: 23/05/2010
 *      Author: zce
 */

#ifndef BEHAVIOUR_H_
#define BEHAVIOUR_H_

#include "world_simulation.h"
#include "Util/util.h"

namespace character {

class Behaviour {
public:
	virtual ~Behaviour();

	virtual DirectionE nextMove(const Coord& currentPosition, std::tr1::shared_ptr<scenario::Scenario> scenario) = 0;
};

}

#endif /* BEHAVIOUR_H_ */
