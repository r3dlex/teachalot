/*
 * cell.h
 *
 *  Created on: 07/05/2010
 *      Author: jeferson
 */

#ifndef CELL_H_
#define CELL_H_

#include "Scenario/cellType.h"
#include "Util/util.h"

namespace scenario {

class Cell {
public:
	Cell(ImageE type, Coord position);
	virtual ~Cell();

	bool pass() const;
	void type(ImageE type);
	ImageE type() const;
	void position(Coord position);
	Coord coordinate() const;

	int weight() const;
	void weight(int w);

protected:
	ImageE _type;
	bool _pass;
	Coord _position;
	int _weight;
};


}  // namespace sceneario


#endif /* CELL_H_ */
