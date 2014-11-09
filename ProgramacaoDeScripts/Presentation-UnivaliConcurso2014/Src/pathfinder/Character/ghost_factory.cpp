/*
 * ghost_factory.cpp
 *
 *  Created on: 23/05/2010
 *      Author: zce
 */

#include "ghost_factory.h"

#include "null_behaviour.h"
#include "ghost_character.h"
#include "follow_behaviour_genetic.h"

namespace character {

static std::tr1::shared_ptr<sprite::CharacterSprite> createGhost(const Coord& pos, ImageE image) {
	Vector position(pos.x*30, pos.y*30);
	std::tr1::shared_ptr<GhostCharacter> ghost(new GhostCharacter(position, make_shared(new NullBehaviour())));
	std::tr1::shared_ptr<sprite::CharacterSprite> sprite(new sprite::CharacterSprite(ghost, image));
	return sprite;
}

std::tr1::shared_ptr<sprite::CharacterSprite> GhostFactory::createGuardianGhost(const Coord& pos) {
	return createGhost(pos, BRAIN);
}

std::tr1::shared_ptr<sprite::CharacterSprite> GhostFactory::createScaredGhost(const Coord& pos) {
	return createGhost(pos, GHOSTBLUE);
}

std::tr1::shared_ptr<sprite::CharacterSprite> GhostFactory::createEvilGhost(const Coord& pos) {
	return createGhost(pos, BRAIN);
}

std::tr1::shared_ptr<sprite::CharacterSprite> GhostFactory::createGeneticGhost(const Coord& pos) {
	return createGhost(pos, MINO);
}

}
