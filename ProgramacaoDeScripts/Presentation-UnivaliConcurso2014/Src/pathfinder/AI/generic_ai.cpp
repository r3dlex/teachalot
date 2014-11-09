/*
 * generic_ai.cpp
 *
 *  Created on: 21/05/2010
 *      Author: jeferson
 */

#include "generic_ai.h"

namespace AI {

GenericAI::GenericAI(std::tr1::shared_ptr<scenario::Scenario> scenario)
:_scenario(scenario)
{
}

GenericAI::~GenericAI() {
}
}
