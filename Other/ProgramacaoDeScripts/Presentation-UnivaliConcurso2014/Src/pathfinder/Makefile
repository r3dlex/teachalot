CXXFLAGS=-O2 -g -I${PWD}/ -Wall

all: crazyMaze

crazyMaze: ./Image/image.o ./Util/util.o ./AI/generic_ai.o ./AI/neural_network.o ./AI/a_star.o ./AI/automatic_character.o ./AI/Genetic/genetic_control.o ./AI/Genetic/genome.o ./Sprite/painter.o ./Sprite/win_sprite.o ./Sprite/sprite.o ./Sprite/character_sprite.o ./Sprite/scenario_sprite.o ./world_simulation.o ./Scenario/scenario1.o ./Scenario/cell.o ./Scenario/scenario.o ./Character/null_behaviour.o ./Character/behaviour.o ./Character/ghost_factory.o ./Character/key.o ./Character/character.o ./Character/key_guardian_behaviour.o ./Character/ghost_character.o ./Character/follow_behaviour_genetic.o ./Character/follow_behaviour.o ./Character/repulse_behaviour.o ./Output/window.o ./game.o ./main.o
	g++ ${CXXFLAGS} ./Image/image.o ./Util/util.o ./AI/generic_ai.o ./AI/neural_network.o ./AI/a_star.o ./AI/automatic_character.o ./AI/Genetic/genetic_control.o ./AI/Genetic/genome.o ./Sprite/painter.o ./Sprite/win_sprite.o ./Sprite/sprite.o ./Sprite/character_sprite.o ./Sprite/scenario_sprite.o ./world_simulation.o ./Scenario/scenario1.o ./Scenario/cell.o ./Scenario/scenario.o ./Character/null_behaviour.o ./Character/behaviour.o ./Character/ghost_factory.o ./Character/key.o ./Character/character.o ./Character/key_guardian_behaviour.o ./Character/ghost_character.o ./Character/follow_behaviour_genetic.o ./Character/follow_behaviour.o ./Character/repulse_behaviour.o ./Output/window.o ./game.o ./main.o -o crazyMaze -lSDL -lSDL_image -lSDL_gfx

clean:
	rm crazyMaze; find -name "*.o" -exec rm {} \;
