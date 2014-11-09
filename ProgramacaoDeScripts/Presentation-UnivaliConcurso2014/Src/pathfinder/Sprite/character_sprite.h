/*
 * character_sprite.h
 *
 *  Created on: 10/05/2010
 *      Author: jeferson
 */

#ifndef CHARACTER_SPRITE_H_
#define CHARACTER_SPRITE_H_

#include <tr1/memory>
#include "entity.h"
#include "Sprite/sprite.h"

namespace sprite {

class CharacterSprite : public Sprite {
public:
	CharacterSprite(std::tr1::shared_ptr<Entity> entity, ImageE image);
	virtual ~CharacterSprite();

	std::tr1::shared_ptr<Entity> entity() const;

	virtual Vector position();
	virtual void update();

	virtual DirectionE direction() const {
		return _entity->direction();
	}

protected:
	std::tr1::shared_ptr<Entity> _entity;
	ImageE _image;
};


}  // namespace sprite


#endif /* CHARACTER_SPRITE_H_ */
