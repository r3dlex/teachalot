/*
 * main.cc
 *
 *  Created on: 06/05/2010
 *      Author: jeferson
 */

#include "game.h"

int main(int argc, char** argv) {
	if( argc == 1 ) {
		Game();
		return 0;
	}
	for( unsigned int i=1;i<argc;++i) {
		Game game(argv[i]);
	};
	return 0;
}
