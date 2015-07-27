#include <stdio.h>

#define N_LINHAS 5 
#define N_COLUNAS 2

int main ()
{
  /* Array de N_LINHAS linhas e N_COLUNAS colunas */
  int a[N_LINHAS][N_COLUNAS] = { {0,0}, {1,2}, {2,4}, {3,6},{4,8}};

  int i, j;

  /* Impressão de valores do array */
  for (i = 0; i < N_LINHAS; i++ )
  {
    for (j = 0; j < N_COLUNAS; j++ )
    {
      printf("a[%d][%d] = %d\n", i,j, a[i][j] );

    }
  }

  return 0;
}
