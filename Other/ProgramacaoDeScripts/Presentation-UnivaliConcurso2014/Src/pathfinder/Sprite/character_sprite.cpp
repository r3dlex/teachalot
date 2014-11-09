/*
 * character_sprite.cpp
 *
 *  Created on: 10/05/2010
 *      Author: jeferson
 */

#include "character_sprite.h"
#include "Character/charecter_type.h"
#include "Image/image.h"
#include <iostream>

namespace sprite {

CharacterSprite::CharacterSprite(std::tr1::shared_ptr<Entity> entity, ImageE image)
	: Sprite(entity->position()), _entity(entity), _image(image)
{
	this->update();
}

CharacterSprite::~CharacterSprite() {
}

std::tr1::shared_ptr<Entity> CharacterSprite::entity() const {
	return _entity;
}

Vector CharacterSprite::position() {
	return _entity->spritePosition();// - Vector(1985, 985);
}

void CharacterSprite::update() {
	_sprite = image::Image::getInstance()->surface(_image);
}


}
