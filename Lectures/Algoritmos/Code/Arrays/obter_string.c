#include <string.h>
#include <stdio.h>

#define ARRAY_SIZE 255

int obter_string(char* str, int n)
{
  char c;
  int i = 0;
  while ((c = getchar()) != '\n' && i < n - 1)
  {
    str[i++] = c;
  }
  str[i] = '\0';

  return i + 1;
}

int main() 
{
  char string[ARRAY_SIZE];
  obter_string(string, ARRAY_SIZE);
  printf("string lida: %s\n", string);
}
