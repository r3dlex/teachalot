/*
 * point.h
 *
 *  Created on: 08/05/2010
 *      Author: jeferson
 */

#ifndef POINT_H_
#define POINT_H_

#include <boost/random/mersenne_twister.hpp>
#include <boost/random/uniform_int.hpp>
#include <boost/random/variate_generator.hpp>
#include <tr1/memory>

enum DirectionE {
	UP, DOWN, RIGHT, LEFT, STAY
};

enum ImageE {
	WALL = 0, GROUND, EXIT, BOB, BRAIN, KEYOFF, KEYON, GHOSTBLUE, MINO, WIN
};


struct Vector {

	Vector(double initX = 0, double initY = 0) {
		x = initX;
		y = initY;
	}

	Vector operator+(const Vector& v2) {
		return Vector(x + v2.x, y + v2.y);
	}

	Vector operator*(double scalar) {
		return Vector(x * scalar, y * scalar);
	}

	Vector operator-(const Vector& v2) {
		return Vector(x - v2.x, y - v2.y);
	}

	double dot(const Vector& o) {
		return x*o.x + y*o.y;
	}

	bool operator==(const Vector& v2) const {
		return ((x == v2.x) && (y == v2.y));
	}

	double x, y;
};

struct Coord {
	Coord(int x = 0, int y = 0) : x(x), y(y) {}

	Coord operator+(const Coord& v2) {
		return Coord(x + v2.x, y + v2.y);
	}

	Coord operator-(const Coord& o) {
		return Coord(x - o.x, y - o.y);
	}

	bool operator==(const Coord& o) const {
		return x == o.x && y == o.y;
	}

  bool operator!=(const Coord& o) const {
    return x != o.x || y != o.y;
  }

	int x, y;
};

struct Transform {
	static Coord vecToCoord(Vector vector) {
		return Coord(vector.x / 30, vector.y / 30);
	}

	static Vector coordToVec(Coord coord) {
		return Vector(coord.x * 30, coord.y * 30);
	}

	static DirectionE coordToDir(Coord delta) {
		if (delta.x == -1) return LEFT;
		if (delta.x ==  1) return RIGHT;
		if (delta.y == -1) return UP;
		if (delta.y ==  1) return DOWN;
		return STAY;
	}


	static Vector dirToVec(DirectionE dir) {
		switch (dir) {
			case UP:
				return Vector(0, -1);
				break;
			case DOWN:
				return Vector(0, 1);
				break;
			case RIGHT:
				return Vector(1, 0);
				break;
			case LEFT:
				return Vector(-1, 0);
				break;
			case STAY:
				return Vector(0, 0);
				break;
			default:
				break;
		}
		return Vector(0,0);
	}

	static Coord dirToCoord(DirectionE dir) {
		switch (dir) {
			case UP:
				return Coord(0, -1);
				break;
			case DOWN:
				return Coord(0, 1);
				break;
			case RIGHT:
				return Coord(1, 0);
				break;
			case LEFT:
				return Coord(-1, 0);
				break;
			case STAY:
				return Coord(0, 0);
				break;
			default:
				break;
		}
		return Coord(0,0);
	}


};

class Random {
public:
	virtual ~Random();
	static std::tr1::shared_ptr<Random> getInstance();
	int roll(int min, int max);
private:
	Random();
	static std::tr1::shared_ptr<Random> _instance;



protected:
	boost::mt19937 gen;
};

template <class T>
std::tr1::shared_ptr<T> make_shared(T* ptr) {
	return std::tr1::shared_ptr<T>(ptr);
}





#endif /* POINT_H_ */
