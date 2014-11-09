#include <stdio.h>

int main() {
	int i = 10;
	int j;

	for (; i < 100; ++i)
		for (j = 0; j < 100; ++j) {
			int numero = i * 100 + j;
			int sum = i + j;
			int sqNumero = sum * sum;
			
			if (sqNumero == numero)
				printf("encontrado %d\n", numero);
		}
			

	return 0;
}
