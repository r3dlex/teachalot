/*
 * scenario_sprite.h
 *
 *  Created on: 08/05/2010
 *      Author: jeferson
 */

#ifndef SCENARIO_SPRITE_H_
#define SCENARIO_SPRITE_H_

#include <tr1/memory>
#include "Sprite/sprite.h"
#include "Scenario/scenario.h"

namespace sprite {

class Scenario_sprite : public Sprite {
public:
	Scenario_sprite(std::tr1::shared_ptr<scenario::Scenario> scenario, SDL_Surface* mainScreen, Vector position);
	virtual ~Scenario_sprite();
	virtual void update();

protected:
	std::tr1::shared_ptr<scenario::Scenario> _scenario;
};

}  // namespace sprite



#endif /* SCENARIO_SPRITE_H_ */
