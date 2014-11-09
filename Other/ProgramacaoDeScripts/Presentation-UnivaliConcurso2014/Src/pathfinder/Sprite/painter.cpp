/*
 * painter.cpp
 *
 *  Created on: 08/05/2010
 *      Author: jeferson
 */

#include "painter.h"
#include <iostream>

namespace sprite {

Painter::Painter(std::tr1::shared_ptr<output::Window> window)
:_window(window)
{

}

Painter::~Painter() {
	// TODO Auto-generated destructor stub
}

Painter::SpriteIt Painter::addSprite(std::tr1::shared_ptr<Sprite> sprite) {
	return _spriteList.insert(_spriteList.end(), sprite);
}

void Painter::draw() {
	for (SpriteIt it = _spriteList.begin(); it != _spriteList.end(); it++) {
		(*it)->update();
		switch ((*it)->direction()) {
			case RIGHT:
				_window->drawSprite((*it)->sprite(), (*it)->position().x, (*it)->position().y);
				break;
			case LEFT:
				_window->drawFHorizontal((*it)->sprite(), (*it)->position().x, (*it)->position().y);
				break;
			default:
				_window->drawSprite((*it)->sprite(), (*it)->position().x, (*it)->position().y);
				break;
		}

	}
}

void Painter::clear() {
	_spriteList.clear();
}


}  // namespace sprite

