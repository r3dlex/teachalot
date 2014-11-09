/*
 * painter.h
 *
 *  Created on: 08/05/2010
 *      Author: jeferson
 */

#ifndef PAINTER_H_
#define PAINTER_H_

#include <vector>
#include <tr1/memory>
#include "Sprite/sprite.h"
#include "Output/window.h"

namespace sprite {

class Painter {
public:
	typedef std::vector<std::tr1::shared_ptr<Sprite> >::iterator SpriteIt;

	Painter(std::tr1::shared_ptr<output::Window> window);
	virtual ~Painter();

	SpriteIt addSprite(std::tr1::shared_ptr<Sprite> sprite);
	void clear();
	void draw();

protected:
	std::tr1::shared_ptr<output::Window> _window;
	std::vector<std::tr1::shared_ptr<Sprite> > _spriteList;
	Vector _oldPosition;

};


}  // namespace sprite


#endif /* PAINTER_H_ */
