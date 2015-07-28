#include <stdio.h>
 
/* declaração */
int maximo(int, int);
 
int main ()
{
   /* local variable definition */
   int a = 100;
   int b = 200;
   int maior;
 
   /* Obtém o maior valor e imprime */
   printf( "Maior: %d\n", maximo(a, b));

   maior = maximo(a, b);
   printf( "Maior: %d\n", maior);
 
   return 0;
}
