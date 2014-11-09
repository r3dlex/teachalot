/*
 * automatic_character.h
 *
 *  Created on: 22/05/2010
 *      Author: jeferson
 */

#ifndef AUTOMATIC_CHARACTER_H_
#define AUTOMATIC_CHARACTER_H_

#include "Util/util.h"
#include "AI/generic_ai.h"
#include "Character/character.h"
#include "Character/charecter_type.h"
#include "entity.h"
#include <tr1/memory>


namespace AI {

class AutomaticCharacter : public character::Character {
public:
	AutomaticCharacter(Vector position,
								std::tr1::shared_ptr<AI::GenericAI> ai,
								std::tr1::shared_ptr<Entity> follow);

	virtual ~AutomaticCharacter();

	DirectionE step();

	void resetAI();

	bool endFollow() const;

	bool on() const;
	void on(bool stats);

protected:
	std::tr1::shared_ptr<AI::GenericAI> _ai;
	std::tr1::shared_ptr<Entity> _follow;
	std::vector<DirectionE> _path;
	unsigned int _indexPath;
	bool _on;
};

}

#endif /* AUTOMATIC_CHARACTER_H_ */
