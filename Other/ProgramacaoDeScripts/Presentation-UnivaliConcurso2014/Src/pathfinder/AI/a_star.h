/*
 * a_star.h
 *
 *  Created on: 18/05/2010
 *      Author: zce
 */

#ifndef A_STAR_H_
#define A_STAR_H_

#include "Scenario/scenario.h"
#include "Util/util.h"
#include "AI/generic_ai.h"

#include <tr1/functional>
#include <vector>
#include <algorithm>

namespace AI {

class AStar : public GenericAI {
public:
	typedef std::tr1::function<float (const Coord&)> CostFunction;

	AStar(std::tr1::shared_ptr<scenario::Scenario> scenario);

	AStar(std::tr1::shared_ptr<scenario::Scenario> scenario, const CostFunction& costFunction);

	int findPath(std::vector<Coord>& path, const Coord& origem, const Coord& destino);
	int findPath(std::vector<DirectionE>& path, const Coord& origem, const Coord& destino);

private:
	CostFunction _locationCost;
};

}
#endif /* A_STAR_H_ */
