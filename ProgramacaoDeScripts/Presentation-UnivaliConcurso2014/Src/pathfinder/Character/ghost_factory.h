/*
 * ghost_factory.h
 *
 *  Created on: 23/05/2010
 *      Author: zce
 */

#ifndef GHOST_FACTORY_H_
#define GHOST_FACTORY_H_

#include "Sprite/character_sprite.h"

namespace character {

class GhostFactory {
public:
	static std::tr1::shared_ptr<sprite::CharacterSprite> createGuardianGhost(const Coord& pos);

	static std::tr1::shared_ptr<sprite::CharacterSprite> createScaredGhost(const Coord& pos);

	static std::tr1::shared_ptr<sprite::CharacterSprite> createEvilGhost(const Coord& pos);

	static std::tr1::shared_ptr<sprite::CharacterSprite> createGeneticGhost(const Coord& pos);
};

}

#endif /* GHOST_FACTORY_H_ */
