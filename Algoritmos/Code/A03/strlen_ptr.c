//Cabeçalho que define size_t
#include <stddef.h>

size_t strlen(const char *str) { 
 size_t comprimento = 0U;

 //Procura 0 (\0)
 while (*(str++)) {
   ++comprimento; 
 }

 return comprimento; 
}
