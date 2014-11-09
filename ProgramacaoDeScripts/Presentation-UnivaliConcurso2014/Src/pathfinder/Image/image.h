/*
 * image.h
 *
 *  Created on: 23/05/2010
 *      Author: jeferson
 */

#ifndef IMAGE_H_
#define IMAGE_H_

#include <tr1/memory>
#include <SDL/SDL.h>
#include "Scenario/cellType.h"
#include "Util/util.h"

namespace image {

class Image {
public:
	virtual ~Image();
	static std::tr1::shared_ptr<Image> getInstance();
	SDL_Surface* surface(ImageE type);

private:
	Image();
	static std::tr1::shared_ptr<Image> _instance;

protected:
	static int const _size = 9;
	static SDL_Surface* _surface[_size];

};

}

#endif /* IMAGE_H_ */
