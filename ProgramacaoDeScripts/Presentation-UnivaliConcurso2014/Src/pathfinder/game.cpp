/*
 * game.cpp
 *
 *  Created on: 06/05/2010
 *      Author: jeferson
 */

#include "game.h"

#include "Scenario/scenario1.h"

#include "Character/follow_behaviour.h"
#include "Character/follow_behaviour_genetic.h"
#include "Character/repulse_behaviour.h"
#include "Character/key_guardian_behaviour.h"
#include "Character/character.h"
#include "Character/ghost_factory.h"
#include "Sprite/character_sprite.h"
#include "Util/util.h"
#include "Sprite/win_sprite.h"

#include "AI/a_star.h"
#include "AI/generic_ai.h"

#include <iostream>

class Game::Private {
public:
	SDL_Event event;
	std::string mapFile;
};

Game::Game(const std::string& map)
:_p(new Private), _endGame(false), _getKey(false), _win(false)
{
	_window.reset(new output::Window(600, 510));
	_painter.reset(new sprite::Painter(_window));

	_p->mapFile = map;

	this->initGame();

	this->mainLoop();
}

void Game::initGame() {
	std::tr1::shared_ptr<scenario::Scenario> scenario1(scenario::Scenario::loadFromFile(_p->mapFile));
	_scenarioPainter.reset(new sprite::Scenario_sprite(scenario1, _window->screen(), Vector(5, 0)));
	_painter->addSprite(_scenarioPainter);

	/* Key */
	_key.reset(new character::Key(Transform::coordToVec(scenario1->key())));

	/* Hero */
	std::tr1::shared_ptr<AI::GenericAI> geneticBOB(new GeneticControl(scenario1));
	_hero.reset(new character::Character(Transform::coordToVec(scenario1->start())));
	std::tr1::shared_ptr<sprite::CharacterSprite> heroSprite(new sprite::CharacterSprite(_hero, BOB));
	_painter->addSprite(heroSprite);

	/* Ghosts */
	std::tr1::shared_ptr<sprite::CharacterSprite> scaredGhostSprite = character::GhostFactory::createScaredGhost(Coord(18, 3));
	std::tr1::shared_ptr<sprite::CharacterSprite> minoSprite = character::GhostFactory::createGeneticGhost(Coord(18, 8));
	std::tr1::shared_ptr<sprite::CharacterSprite> guardianGhostSprite = character::GhostFactory::createGuardianGhost(Coord(18, 13));

	_scaredGhost = std::tr1::static_pointer_cast<character::GhostCharacter>(scaredGhostSprite->entity());
	_mino = std::tr1::static_pointer_cast<character::GhostCharacter>(minoSprite->entity());
	_guardianGhost = std::tr1::static_pointer_cast<character::GhostCharacter>(guardianGhostSprite->entity());

	_scaredGhost->behaviour(make_shared(new character::RepulseBehaviour(_hero, _mino)));
	_mino->behaviour(make_shared(new character::FollowBehaviour(_hero)));
	_guardianGhost->behaviour(make_shared(new character::KeyGuardianBehaviour(_key, _hero, _scaredGhost)));

	_enemies.push_back(_scaredGhost);
	_painter->addSprite(scaredGhostSprite);
	_enemies.push_back(_guardianGhost);
	_painter->addSprite(guardianGhostSprite);
	_enemies.push_back(_mino);
	_painter->addSprite(minoSprite);

	_world.reset(new WorldSimulation(scenario1));
}

Game::~Game() {
	delete _p;
}


void Game::mainLoop() {
	bool paused = true;

	DirectionE playerDirection = STAY;

	while (!_endGame) {

		while (SDL_PollEvent(&_p->event)) {
			if (_p->event.type == SDL_QUIT) {
				_endGame = true;
			}

			switch (_p->event.type) {
				case SDL_KEYDOWN:
					switch (_p->event.key.keysym.sym) {
						case SDLK_LEFT:
							playerDirection = LEFT;
							break;
						case SDLK_RIGHT:
							playerDirection = RIGHT;
							break;
						case SDLK_UP:
							playerDirection = UP;
							break;
						case SDLK_DOWN:
							playerDirection = DOWN;
							break;
						case SDLK_ESCAPE:
							::exit(0);
							break;
						default:
							break;
					}
					break;
				default:
					break;
			}
		}

		if (playerDirection != STAY) paused = false;

		if (paused) {
			_painter->draw();
			_window->flipScreen();
			continue;
		}

		int currentTime = SDL_GetTicks();

		for (unsigned int i = 0; i < _enemies.size(); ++i) {
			if (!_world->moving(_enemies[i])) {
				_world->beginMovement(currentTime, _enemies[i], _enemies[i]->nextMove(_world->scenario()));
			}
		}

		if (!_world->moving(_hero)) {
			_world->beginMovement(currentTime, _hero, playerDirection);
		}

		_world->updateAnimation(currentTime);
		updateGame();
		_painter->draw();
		_window->flipScreen();

		if (_endGame) {

		}
	}
	SDL_Quit();
}

void Game::updateGame() {
	if (_win && !_world->moving(_hero)) {
		SDL_Delay(1000);
		_painter->clear();
		_painter->addSprite(make_shared(new sprite::WinSprite()) );
	}

	if (_getKey && (_hero->position() == Transform::coordToVec(_world->scenario()->exit()))) {
		_win = true;
	}

	/* Hero gets key */
	if (_hero->position() == _key->position() && !_getKey) {
		_getKey = true;
		_world->scenario()->cell(_hero->position())->type(GROUND);
		_scenarioPainter->update();
	}

	/* Key position update */
	if (_getKey) {
		_key->position(_hero->position());
	}

	/* Guardian gets key */
	if (_guardianGhost->position() == _key->position()) {
		if (!_getKey) {
			_world->scenario()->cell(_key->position())->type(GROUND);
		}
		_getKey = false;
		_key->position(_scaredGhost->position());
		_world->scenario()->cell(_scaredGhost->position())->type(KEYOFF);
		_scenarioPainter->update();
	}

	/* Mino get hero*/
	if (_mino->position() == _hero->position()) {
		_hero->position(_guardianGhost->position());
	}

}
