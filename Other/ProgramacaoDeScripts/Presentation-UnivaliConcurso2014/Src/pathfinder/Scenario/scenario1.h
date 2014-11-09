/*
 * scenario1.h
 *
 *  Created on: 07/05/2010
 *      Author: jeferson
 */

#ifndef SCENARIO1_H_
#define SCENARIO1_H_

#include "scenario.h"

namespace scenario {

class Scenario1 : public Scenario{
public:
	Scenario1(unsigned int w, unsigned int h);
	virtual ~Scenario1();

	virtual void scenarioMount();
};


}  // namespace scenario


#endif /* SCENARIO1_H_ */
