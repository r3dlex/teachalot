/*
 * scenario_sprite.cpp
 *
 *  Created on: 08/05/2010
 *      Author: jeferson
 */

#include "scenario_sprite.h"
#include "Image/image.h"
#include "Scenario/cellType.h"

namespace sprite {

Scenario_sprite::Scenario_sprite(std::tr1::shared_ptr<scenario::Scenario> scenario, SDL_Surface* mainScreen, Vector position)
:Sprite(position), _scenario(scenario)
{

	_sprite = SDL_CreateRGBSurface((SDL_HWSURFACE | SDL_SRCALPHA),
									mainScreen->w,
									mainScreen->h,
									16,
									mainScreen->format->Rmask,
									mainScreen->format->Gmask,
									mainScreen->format->Bmask,
									mainScreen->format->Amask);

	this->update();
}

Scenario_sprite::~Scenario_sprite() {

}

void Scenario_sprite::update() {
	SDL_Surface* surf;

	SDL_Rect positionRect = { _position.x, _position.y, 0, 0};

	positionRect.x = _position.x;
	positionRect.y = _position.y;

	surf = image::Image::getInstance()->surface(_scenario->cell(0, 0)->type());
	for (unsigned int j = 0; j < _scenario->sizeH(); j++) {
		positionRect.y = surf->h * j;
		for (unsigned int i = 0; i < _scenario->sizeW(); i++) {
			positionRect.x = surf->w * i;


			surf = image::Image::getInstance()->surface(_scenario->cell(i, j)->type());

			SDL_BlitSurface(surf, NULL, _sprite, &positionRect);
		}
	}
}


}  // namespace sprite

