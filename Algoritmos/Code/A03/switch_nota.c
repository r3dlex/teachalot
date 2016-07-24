#include <stdio.h>

int main ()
{
  /* Definicao de indicativo de nota: A, B, C, D ou F*/
  char indicativo = 'B';

  switch(indicativo)
  {
    case 'A' :
      printf("Excelente!\n" );
      break;
    case 'B' :
    case 'C' :
      printf("Muito bem!\n" );
      break;
    case 'D' :
      printf("Regular\n" );
      break;
    case 'F' :
      printf("Tente novamente\n" );
      break;
    default :
      printf("Indicativo invalido" );
  }
  printf("O indicativo eh %c\n", indicativo);

  return 0;
}
