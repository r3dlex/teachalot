/*
 * generic_ai.h
 *
 *  Created on: 21/05/2010
 *      Author: jeferson
 */

#ifndef GENERIC_AI_H_
#define GENERIC_AI_H_

#include "Scenario/scenario.h"
#include <tr1/memory>
#include <Util/util.h>

namespace AI {

class GenericAI {
public:
	GenericAI(std::tr1::shared_ptr<scenario::Scenario> scenario);
	virtual ~GenericAI();

	virtual int findPath(std::vector<DirectionE>& path, const Coord& origem, const Coord& destino) = 0;

protected:
	std::tr1::shared_ptr<scenario::Scenario> _scenario;
};

}

#endif /* GENERIC_AI_H_ */
