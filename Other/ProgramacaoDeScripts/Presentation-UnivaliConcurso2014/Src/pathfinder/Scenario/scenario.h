/*
 * scenario.h
 *
 *  Created on: 07/05/2010
 *      Author: jeferson
 */

#ifndef SCENARIO_H_
#define SCENARIO_H_

#include <tr1/memory>
#include <vector>
#include "cell.h"
#include "cellType.h"
#include "Util/util.h"

namespace scenario {

class Scenario {
public:
	typedef std::tr1::shared_ptr<Cell> CellPtr;
	typedef std::vector<std::vector<CellPtr> > CellGrid;

	Scenario(unsigned int sizeW, unsigned int sizeH);
	virtual ~Scenario();

	static std::tr1::shared_ptr<Scenario> loadFromFile(const std::string& filename);

	unsigned int sizeW() const;
	unsigned int sizeH() const;
	Coord exit() const;
	Coord start() const;
	Coord key() const;
	std::tr1::shared_ptr<Cell> cell(unsigned int x, unsigned int y);
	std::tr1::shared_ptr<Cell> cell(const Vector& position);


protected:
	unsigned int _sizeW, _sizeH;
	static Coord _exit, _start, _key;
	CellGrid _cell;

};


}  // namespace name


#endif /* SCENARIO_H_ */
