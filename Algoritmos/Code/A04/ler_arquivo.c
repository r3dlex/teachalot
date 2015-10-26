#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct ResultadoDaLeitura {
  char*** dados;
  int numeroDeLinhas;
};

//Declaracao da funcao ler
struct ResultadoDaLeitura ler(FILE* ponteiro_do_arquivo);

int main() 
{
  //struct que identifica um arquivo para ler (entrada)
  FILE *ponteiro_arquivo_de_entrada;

  /*r  - aberto para leitura*/
  /*w  - aberto para escrita*/
  /*a  - aberto no final do arquivo (cria se nao existe)*/
  /*r+ - leitura e escrita (comeco)*/
  /*w+ - leitura e escrita (sobrescreve arquivo - recria)*/
  /*a+ - leitura e escrita, abre no final (cria se nao existe)*/
  char modo[] = "r";
  char arquivo_de_entrada[] = "saida.txt";

  //Abre o arquivo em modo de leitura
  ponteiro_arquivo_de_entrada = fopen(arquivo_de_entrada, modo);

  if (ponteiro_arquivo_de_entrada == NULL) 
  {
    fprintf(stderr, "Impossivel abrir arquivo de entrada %s\n", arquivo_de_entrada);
    exit(1);
  }

  struct ResultadoDaLeitura resultado_da_leitura = ler(ponteiro_arquivo_de_entrada);

  //TODO - Imprimir os valores lidos e
  //  liberar a memoria alocada pelo ler
 
  fclose(ponteiro_arquivo_de_entrada);
}

struct ResultadoDaLeitura ler(FILE *ponteiro_do_arquivo) 
{
  struct ResultadoDaLeitura resultado;
  const int MAXIMO_DE_LINHAS = 10; 
  const int NUMERO_DE_COLUNAS = 2;
  resultado.dados = (char***)malloc(sizeof(char***) * MAXIMO_DE_LINHAS);
  
  char login[255];
  char senha[255];

  //Pula a primeira linha
  char lido = 0;
  //Enquanto houver algo para ler
  while ((lido = fgetc(ponteiro_do_arquivo)) != '\n' && lido != EOF);
  int linha = 0;
  while (feof(ponteiro_do_arquivo) == 0) 
  {
    int lidos = 0;
    lidos = fscanf(ponteiro_do_arquivo, "%254s %254s\n", login, senha);
    resultado.dados[linha] = malloc(sizeof(char*) * NUMERO_DE_COLUNAS);
    //strdup usa malloc para copiar a string
    resultado.dados[linha][0] = strdup(login);
    resultado.dados[linha][1] = strdup(senha);
    linha++;
  }

  printf("Linhas lidas: %d\n", linha);
  resultado.numeroDeLinhas = linha;

  return resultado;
}
