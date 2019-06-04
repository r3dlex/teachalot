#include <stdio.h>

#define TAMANHO_DO_ARRAY 10

int main ()
{
  /* Array de 8 inteiros */
  int n[TAMANHO_DO_ARRAY]; 
  int i, j;

  /* Inicializa o valor de todas as posições. 
   * Inicialmente os valores são 0 */
  for (i = 0; i < TAMANHO_DO_ARRAY; i++)
  {
    n[i] = i + 128; //Soma 128 ao valor do elemento 
  }

  /* Imprime o valor de cada elemento do array*/
  for (j = 0; j < TAMANHO_DO_ARRAY; j++)
  {
    printf("n[%d] = %d\n", j, n[j] );
  }

  return 0;
}
