#include "pointer.h"
#include <stdio.h>

int main() {
	int a = 2;
	int* b = &a;
	int c = 3;

	doX(&a);
	doY(a);
	b = &c;	
	doZ(b);

	printf("values %d %d %d\n", a, *b, c);
	
	return 0;
}
