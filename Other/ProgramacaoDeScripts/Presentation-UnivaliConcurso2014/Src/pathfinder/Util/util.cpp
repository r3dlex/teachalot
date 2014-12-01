/*
 * util.cpp
 *
 *  Created on: 19/05/2010
 *      Author: jeferson
 */

#include "util.h"

#include <sys/time.h>

std::tr1::shared_ptr<Random> Random::_instance;

Random::Random() {
	struct timeval tv;
	gettimeofday(&tv, 0);
	gen.seed(tv.tv_sec * 1000000 + tv.tv_usec);
}

Random::~Random() {}


std::tr1::shared_ptr<Random> Random::getInstance() {
	if (_instance == 0) {
		_instance.reset(new Random());
	}
	return _instance;
}

int Random::roll(int min, int max) {
	boost::uniform_int<> dist(min, max);
	boost::variate_generator<boost::mt19937&, boost::uniform_int<> > die(gen, dist);
	return die();
}

