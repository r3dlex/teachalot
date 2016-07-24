#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>

int main() {
  //struct que identifica um arquivo para ler (entrada)
  FILE *ponteiro_arquivo_de_entrada;
  //struct que identifica um arquivo para escrita (saida)
  FILE *ponteiro_arquivo_de_saida;

  /*r  - aberto para leitura*/
  /*w  - aberto para escrita*/
  /*a  - aberto no final do arquivo (cria se nao existe)*/
  /*r+ - leitura e escrita (comeco)*/
  /*w+ - leitura e escrita (sobrescreve arquivo - recria)*/
  /*a+ - leitura e escrita, abre no final (cria se nao existe)*/
  char modo[] = "r";
  char arquivo_de_entrada[] = "entrada.txt";
  char arquivo_de_saida[] = "saida.txt";

  //Abre o arquivo em modo de leitura
  ponteiro_arquivo_de_entrada = fopen(arquivo_de_entrada, modo);

  if (ponteiro_arquivo_de_entrada == NULL) {
    fprintf(stderr, "Impossivel abrir arquivo de entrada %s\n", 
        arquivo_de_entrada);

    exit(1);
  }

  //Abre o arquivo em modo de escrita e o
  //cria automaticamente se nao existir
  ponteiro_arquivo_de_saida = fopen(arquivo_de_saida, "w");

  if (ponteiro_arquivo_de_saida == NULL) {
    fprintf(stderr, "Impossivel abrir o arquivo de saida %s\n",
        arquivo_de_saida);

    exit(1);
  }
}
