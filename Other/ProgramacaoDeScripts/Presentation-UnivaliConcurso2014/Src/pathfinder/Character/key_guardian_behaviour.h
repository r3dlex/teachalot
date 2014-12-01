/*
 * follow_behaviour.h
 *
 *  Created on: 23/05/2010
 *      Author: zce
 */

#ifndef KEY_GUARDIAN_BEHAVIOUR_H_
#define KEY_GUARDIAN_BEHAVIOUR_H_

#include "behaviour.h"
#include "key.h"
#include "Util/util.h"

namespace character {

class KeyGuardianBehaviour: public Behaviour {
public:
	KeyGuardianBehaviour(std::tr1::shared_ptr<Entity> key,
			std::tr1::shared_ptr<Entity> hero,
			std::tr1::shared_ptr<Entity> scared);
	virtual ~KeyGuardianBehaviour();

	DirectionE nextMove(const Coord& currentPosition, std::tr1::shared_ptr<scenario::Scenario> scenario);

private:
	std::tr1::shared_ptr<Entity> _key;
	std::tr1::shared_ptr<Entity> _hero;
	std::tr1::shared_ptr<Entity> _scared;
};

}

#endif /* FOLLOW_BEHAVIOUR_H_ */
