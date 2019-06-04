#include <string.h>
#include <stdio.h>

#define TAMANHO_DO_ARRAY 255

int obter_string(char str[], int n)
{
  int i = 0;
  char c;
  while ((c = getchar()) != '\n' && i < n - 1)
  {
    str[i++] = c;
  }
  str[i] = '\0';

  return i;
}


int main() 
{
  char nome[TAMANHO_DO_ARRAY];
  obter_string(nome, TAMANHO_DO_ARRAY);
  printf("string lida: %s\n", nome);

  return 0;
}
