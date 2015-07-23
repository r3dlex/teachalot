#include<stdio.h>

#define CONCAT(x, y) x##y

int main (void)
{
  int teste = 1000 ;

  /* igual a "tes" + "te" */
  printf(" %i \n", CONCAT ( tes, te ) );

  return 0;
}
