#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#ifdef _WIN32
#include <windows.h>
#endif

#define TAMANHO_MAXIMO_DA_STRING 1024

struct Teste
{
  int i;
  float PI;
  char A;
  char* n;
};

int main()
{
  //Ponteiro para struct Teste
  struct Teste* um_ponteiro;
  um_ponteiro = (struct Teste*) malloc(sizeof(struct Teste));

  um_ponteiro->i = 10;
  um_ponteiro->PI = 3.14;
  um_ponteiro->A = 'a';
  //Aloca memoria para a string interna a struct.
  //Ponteiro / array de caracteres (string)
  um_ponteiro->n = (char*) malloc(sizeof(char) * (TAMANHO_MAXIMO_DA_STRING + 1));
  strcpy(um_ponteiro->n, "Minha string de teste!");

  printf("Primeiro: %d\n", um_ponteiro->i);
  printf("Segundo: %.2f\n", um_ponteiro->PI);
  printf("Terceiro: %c\n", um_ponteiro->A);
  printf("Quarto: %s\n", um_ponteiro->n);

  //Libera o ponteiro alocado para a string antes,
  //nao e possivel faze-lo depois!
  free(um_ponteiro->n);
  //Libera o ponteiro da struct
  free(um_ponteiro);

  return 0;
}
