#include <stdio.h>

int main ()
{
  /* Array de 8 inteiros */
  int n[8]; 
  int i, j;

  /* Inicializa o valor de todas as posições. 
   * Inicialmente os valores são 0 */
  for (i = 0; i < 10; i++)
  {
    n[i] = i + 128; //Soma 128 ao valor do elemento 
  }

  /* Imprime o valor de cada elemento do array*/
  for (j = 0; j < 10; j++)
  {
    printf("n[%d] = %d\n", j, n[j] );
  }

  return 0;
}
