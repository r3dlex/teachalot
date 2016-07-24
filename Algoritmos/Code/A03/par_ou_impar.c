#include <stdio.h>

int main() 
{
  int numero;

  printf("Insira o número: ");
  scanf("%d", &numero);

  if (numero % 2 == 0) 
    printf("eh par\n");
  else 
    printf("eh impar\n");

  return 0;
}
