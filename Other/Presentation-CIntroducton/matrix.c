#include <stdio.h>

int main() {
	int mat[4][4] = {
		1, 0, 0, 0,
		0, 1, 0, 0,
		0, 0, 1, 0,
		0, 0, 0, 1
	};

	int i, j;

	for (i = 0; i < 4; ++i)
		for (j = 0; j < 4; ++j)
			printf("a(%d, %d) = %d\n", i, j, mat[i][j]);

	return 0;
}
