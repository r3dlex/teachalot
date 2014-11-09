/*
 * a_star.cpp
 *
 *  Created on: 18/05/2010
 *      Author: zce
 */

#include "a_star.h"

#include <algorithm>
#include <cmath>
#include <stack>

namespace {

float euclideanDistance(const Coord& orig, const Coord& dest)
{
	int x = orig.x - dest.x;
	int y = orig.y - dest.y;
	return sqrt(x*x + y*y);
}

struct Node {
	Coord coord;
	int g;		// real distance from origin
	float h;	// real distance to end
	const Node* previous;

	Node() : coord(-1, -1), g(-1), h(-1), previous(0) {}

	Node(const Coord& coord, int g, float h, const Node* previous)
		: coord(coord), g(g), h(h), previous(previous)
	{}

	bool operator==(const Node& o) const {
		return coord == o.coord;
	}
};

struct NodeComparator {
	NodeComparator(Node *nodes, unsigned int width) : nodes(nodes), width(width) {}

	bool operator()(const Coord& a, const Coord& b) const {
		Node& x = nodes[a.y * width + a.x];
		Node& y = nodes[b.y * width + b.x];
		return x.g + x.h > y.g + y.h;
	}

	Node* nodes;
	unsigned int width;
};

}

float nullCost(const Coord&) {
	return 0.0;
}

namespace AI {

AStar::AStar(std::tr1::shared_ptr<scenario::Scenario> scenario)
	: GenericAI(scenario), _locationCost(nullCost) {
}

AStar::AStar(std::tr1::shared_ptr<scenario::Scenario> scenario, const CostFunction& costFunction)
	: GenericAI(scenario), _locationCost(costFunction) {
}

int AStar::findPath(std::vector<Coord>& path, const Coord& orig, const Coord& dest)
{
	unsigned int numTiles = _scenario->sizeW() * _scenario->sizeH();
	bool* isClosed = new bool[numTiles];
	bool* isOpen = new bool[numTiles];
	int openCount = 0;
	Node* openNodes = new Node[numTiles];

	std::vector<Coord> queue;
	NodeComparator comparator(openNodes, _scenario->sizeW());

	make_heap(queue.begin(), queue.end(), comparator);

	for (unsigned int i = 0; i < numTiles; ++i) {
		isClosed[i] = false;
		isOpen[i] = false;
	}

	Node nodeOrig(orig, 0.0, euclideanDistance(orig, dest), 0);

	unsigned int idxOrigin = nodeOrig.coord.y * _scenario->sizeW() + nodeOrig.coord.x;
	isOpen[idxOrigin] = true;
	openCount++;
	openNodes[idxOrigin] = nodeOrig;

	queue.push_back(nodeOrig.coord);
	push_heap(queue.begin(), queue.end(), comparator);

	Node nodeDest(dest, -1.0, 0.0, 0);

	const Node* goal = 0;

	while (openCount) {
		pop_heap(queue.begin(), queue.end(), comparator);
		Coord v = queue.back();
		queue.pop_back();

		unsigned int idxV = v.y * _scenario->sizeW() + v.x;
		const Node& x = openNodes[idxV];

		isOpen[idxV] = false;
		openCount--;

		if (x.coord == dest) {
			nodeDest.g = x.g;
			nodeDest.previous = x.previous;
			goal = &nodeDest;
			break;
		}

		isClosed[idxV] = true;

		for (int i = -1; i < 2; ++i) {
			for (int j = -1; j < 2; ++j) {
				if ((i == 0 && j != 0) || (i != 0 && j == 0)) {
					Coord neighbour = Coord(v.x + i, v.y + j);

					if (neighbour.x < 0 || neighbour.y < 0
							|| neighbour.x >= int(_scenario->sizeW())
							|| neighbour.y >= int(_scenario->sizeH())
							|| !_scenario->cell(neighbour.x, neighbour.y)->pass()) {
						continue;
					}

					Node nodeNeighbour(neighbour, 0, 0, &x);
					unsigned int idxNeighbour = neighbour.y * _scenario->sizeW() + neighbour.x;
					if (isClosed[idxNeighbour]) {
						continue;
					}

					nodeNeighbour.g = x.g + 1.0 + _locationCost(nodeNeighbour.coord);

					bool alreadyOpen = isOpen[idxNeighbour];

					if (!alreadyOpen) {
						nodeNeighbour.h = euclideanDistance(nodeNeighbour.coord, dest)
								+ _locationCost(nodeNeighbour.coord);

						isOpen[idxNeighbour] = true;
						openCount++;
						openNodes[idxNeighbour] = nodeNeighbour;

						queue.push_back(nodeNeighbour.coord);
						push_heap(queue.begin(), queue.end(), comparator);

					} else if (nodeNeighbour.g < openNodes[idxNeighbour].g) {
						nodeNeighbour.h = euclideanDistance(nodeNeighbour.coord, dest)
								+ _locationCost(nodeNeighbour.coord);

						openNodes[idxNeighbour] = nodeNeighbour;
					}
				}
			}
		}
	}

	int cost = goal->g;

	std::stack<Coord> s;
	while (goal != 0) {
		s.push(goal->coord);
		goal = goal->previous;
	}
	while (!s.empty()) {
		path.push_back(s.top());
		s.pop();
	}

	return cost;
}

int AStar::findPath(std::vector<DirectionE>& path, const Coord& origem, const Coord& destino) {

	std::vector<Coord> pathCoord;
	int result = this->findPath(pathCoord, origem, destino);

	for (unsigned int i = 0; i < pathCoord.size() - 1; i++) {
		path.push_back(Transform::coordToDir(pathCoord[i + 1] - pathCoord[i]));
	}
	return result;
}

}
