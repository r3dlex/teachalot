#include <stdio.h>

int main ()
{
  /* Declaração de valoriável inteira e ponteiro */
  int  valor = 13;
  int  *ip;       

  // ip aponta para a referência a valor
  ip = &valor; 

  printf("Endereco de valor (&): %x\n", &valor  );

  /* address stored in pointer valoriable */
  printf("ip: %x\n", ip );

  /* Acesso ao valor armazenado pelo ponteiro */
  printf("valor de *ip: %d\n", *ip);

  return 0;
}
