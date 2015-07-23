#include<stdio.h>

/* foo equivale a "foo"  */
#define STRING(foo)  #foo

int main (void)
{
  printf ( STRING( Estou aqui ) "\n" );

  return 0;
}
