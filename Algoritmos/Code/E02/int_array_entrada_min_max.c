#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define NUMERO_DE_INTEIROS 10

void metodoX(int* array_int, int n) 
{
  for (int i = 0; i < n; ++i) 
  {
    scanf("%d", &array_int[i]);
  }
}


int main(int argc, char *argv[]) 
{
  int array_int[NUMERO_DE_INTEIROS];

  metodoX(array_int, NUMERO_DE_INTEIROS);

  int temp = 0;
  for (int i = 0; i < NUMERO_DE_INTEIROS; i++) 
  {
    for (int j = NUMERO_DE_INTEIROS - 1; j > i; j--) 
    {
      if (array_int[j] < array_int[j-1]) 
      {
        int temp = array_int[j];
        array_int[j] = array_int[j-1];
        array_int[j - 1] = temp;
      }                   
    }
  }

  printf("A? = %d, B? = %d\n", array_int[9], array_int[0]);

  int array_x[2][NUMERO_DE_INTEIROS];

  for (int i = 0; i < NUMERO_DE_INTEIROS; i++) {
    array_x[0][i] = 0;
    array_x[1][i] = 0;

    for (int j = 0; j < (NUMERO_DE_INTEIROS - 1); j++)
      if (array_int[i] == array_int[j + 1]) {
        ++array_x[0][i];
        array_x[1][i] = array_int[i];
      }
  }

  int valor;
  int k = 0;
  valor = array_x[0][0];

  for (int j = 0; j < NUMERO_DE_INTEIROS; j++) 
  {
    if (valor < array_x[0][j])
    {
      valor = array_x[1][j];
      k = j;
    }
  }
  printf("C? = %d D? = %d\n", valor, k);

  getchar();

  return EXIT_SUCCESS;
}
