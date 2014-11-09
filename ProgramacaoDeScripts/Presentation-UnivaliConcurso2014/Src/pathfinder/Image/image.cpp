/*
 * image.cpp
 *
 *  Created on: 23/05/2010
 *      Author: jeferson
 */

#include "image.h"
#include <SDL/SDL_image.h>

namespace image {

std::tr1::shared_ptr<Image> Image::_instance;
SDL_Surface* Image::_surface[_size];

Image::Image() {
	_surface[0] = IMG_Load("img/torrinhaSujaDeMeuDeus.png");
	_surface[1] = IMG_Load("img/tijolinhos.png");
	_surface[2] = IMG_Load("img/saida.png");
	_surface[3] = IMG_Load("img/mulherPoderosaDecoteSafadona.png");
	_surface[4] = IMG_Load("img/cerebro.png");
	_surface[5] = IMG_Load("img/chave.png");
	_surface[6] = IMG_Load("img/keyON.png");
	_surface[7] = IMG_Load("img/fantasmaVermelho.png");
	_surface[8] = IMG_Load("img/diabinhoSemFogo.png");
	_surface[9] = IMG_Load("img/win.png");
}

Image::~Image() {
//	delete [] _surface;
}

SDL_Surface* Image::surface(ImageE type) {
	return _surface[type];
}

std::tr1::shared_ptr<Image> Image::getInstance() {
	if (_instance == 0) {
		_instance.reset(new Image());
	}
	return _instance;
}

}
