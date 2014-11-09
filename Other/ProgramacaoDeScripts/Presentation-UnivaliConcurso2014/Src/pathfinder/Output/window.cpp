/*
 * window.cpp
 *
 *  Created on: 06/05/2010
 *      Author: jeferson
 */

#include "window.h"
#include <SDL/SDL_rotozoom.h>
//#include <SDL/SDL_gfxBlitFunc.h>

namespace output {

Window::Window(unsigned int w, unsigned int h)
:_w(w), _h(h)
{
	SDL_Init(SDL_INIT_VIDEO);
	_screen = SDL_SetVideoMode(_w, _h, 16, SDL_HWSURFACE | SDL_DOUBLEBUF);
	SDL_WM_SetCaption("Pathfinder", "Pathfinder");

}

Window::~Window() {
}

SDL_Surface* Window::screen() {
	return _screen;
}

void Window::drawSprite(SDL_Surface* sprite, unsigned int x, unsigned int y) {
	SDL_Rect position = {x, y};
	SDL_BlitSurface(sprite, NULL, _screen, &position);
}

void Window::drawFHorizontal(SDL_Surface* sprite, unsigned int x, unsigned int y) {
	SDL_Rect position = {x, y};
	SDL_BlitSurface(rotozoomSurfaceXY(sprite, 0, -1, 1, 0), NULL, _screen, &position);
}

void Window::flipScreen() {
	SDL_Flip(_screen);
}


}  // namespace output

