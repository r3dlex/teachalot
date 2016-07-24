//Cabeçalho que define size_t
#include <stddef.h>

size_t strlen(const char *str) { 
  size_t comprimento;

  //Procura 0 (\0)
  for(comprimento = 0U; str[i] != '\0'; ++comprimento) {
    /* sem corpo */;
  }

  return comprimento; 
}
