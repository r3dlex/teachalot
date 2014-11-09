/*
 * win_sprite.cpp
 *
 *  Created on: 25/05/2010
 *      Author: jeferson
 */

#include "win_sprite.h"
#include "Image/image.h"
#include "Util/util.h"

namespace sprite {

WinSprite::WinSprite()
:Sprite(Vector(0, 0))
{
	_sprite = image::Image::getInstance()->surface(WIN);

}

WinSprite::~WinSprite() {
	// TODO Auto-generated destructor stub
}

void WinSprite::update() {
}

}

