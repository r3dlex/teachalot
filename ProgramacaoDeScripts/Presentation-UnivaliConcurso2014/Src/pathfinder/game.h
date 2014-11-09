/*
 * game.h
 *
 *  Created on: 06/05/2010
 *      Author: jeferson
 */

#ifndef GAME_H_
#define GAME_H_

#include "Character/key.h"
#include "Character/ghost_character.h"
#include "Output/window.h"
#include "Sprite/painter.h"
#include "world_simulation.h"
#include "Sprite/scenario_sprite.h"
#include "AI/Genetic/genetic_control.h"

#include <string>

#include <tr1/memory>

class Game {
public:
	Game(const std::string& map="map0.txt");
	virtual ~Game();

	void mainLoop();

protected:
	void initGame();

	void updateGame();

private:
	class Private;
	Private* _p;

protected:
	bool _endGame;
	static int const FPS = 40;
	std::tr1::shared_ptr<output::Window> _window;
	std::tr1::shared_ptr<sprite::Painter> _painter;
	std::tr1::shared_ptr<WorldSimulation> _world;

	std::tr1::shared_ptr<character::Key> _key;
	bool _getKey, _win;

	std::tr1::shared_ptr<GeneticControl> _geneControl;

	std::tr1::shared_ptr<character::Character> _hero;
	std::tr1::shared_ptr<sprite::Scenario_sprite> _scenarioPainter;

	Coord _ghostHouse;

	std::vector<std::tr1::shared_ptr<character::GhostCharacter> > _enemies;
	std::tr1::shared_ptr<character::GhostCharacter> _guardianGhost;
	std::tr1::shared_ptr<character::GhostCharacter> _scaredGhost;
	std::tr1::shared_ptr<character::GhostCharacter> _mino;
};

#endif /* GAME_H_ */
