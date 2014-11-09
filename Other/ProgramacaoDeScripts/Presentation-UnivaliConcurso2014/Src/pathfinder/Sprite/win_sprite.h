/*
 * win_sprite.h
 *
 *  Created on: 25/05/2010
 *      Author: jeferson
 */

#ifndef WIN_SPRITE_H_
#define WIN_SPRITE_H_

#include "Sprite/sprite.h"

namespace sprite {

class WinSprite : public Sprite {
public:
	WinSprite();
	virtual ~WinSprite();

	void update();
};

}

#endif /* WIN_SPRITE_H_ */
