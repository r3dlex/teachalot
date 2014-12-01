/*
 * window.h
 *
 *  Created on: 06/05/2010
 *      Author: jeferson
 */

#ifndef WINDOW_H_
#define WINDOW_H_

#include <SDL/SDL.h>

namespace output {

class Window {
public:
	Window(unsigned int w, unsigned int h);
	virtual ~Window();

	unsigned int w() const {
		return _w;
	}

	void w(unsigned int w) {
		_w = w;
	}

	unsigned int h() const {
		return _h;
	}

	void h(unsigned int h) {
		_h = h;
	}

	void drawSprite(SDL_Surface* sprite, unsigned int x, unsigned int y);
	void drawFHorizontal(SDL_Surface* sprite, unsigned int x, unsigned int y);
	void flipScreen();
	SDL_Surface* screen();


protected:
	unsigned int _w, _h;
	SDL_Surface* _screen;
};

}  // namespace output



#endif /* WINDOW_H_ */
