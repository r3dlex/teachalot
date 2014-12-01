#ifndef UNION_H_
#define UNION_H_

union Vec3 {
	struct { float x, y, z; };
	float c[3];
};

#endif
