#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

//Declaracao da funcao escrever
void escrever(FILE* ponteiro_do_arquivo);

//Numero de linhas e colunas do arquivo
const size_t NUMERO_DE_LINHAS = 8;
const size_t NUMERO_DE_COLUNAS = 2;
//Conteudos a serem escritos
const char* conteudo[NUMERO_DE_LINHAS][NUMERO_DE_COLUNAS] = 
{
  {"#login", "senha"},
  {"abc", "123"},
  {"bac", "32345"},
  {"ab", "olamundo"},
  {"quemeh", "naosei"},
  {"joaodasilva", "minhasenhasecreta"},
  {"blah", "blabla"},
  {"whowantsto", "liveforever"}
};

int main() 
{
  //struct que identifica um arquivo para escrita (saida)
  FILE *ponteiro_arquivo_de_saida;

  /*r  - aberto para leitura*/
  /*w  - aberto para escrita*/
  /*a  - aberto no final do arquivo (cria se nao existe)*/
  /*r+ - leitura e escrita (comeco)*/
  /*w+ - leitura e escrita (sobrescreve arquivo - recria)*/
  /*a+ - leitura e escrita, abre no final (cria se nao existe)*/
  const char modo[] = "w";
  const char arquivo_de_saida[] = "saida.txt";

  //Abre o arquivo em modo de escrita e o
  //cria automaticamente se nao existir
  ponteiro_arquivo_de_saida = fopen(arquivo_de_saida, modo);

  if (ponteiro_arquivo_de_saida == NULL) 
  {
    fprintf(stderr, "Impossivel abrir o arquivo de saida %s\n",
        arquivo_de_saida);
    exit(1);
  }

  escrever(ponteiro_arquivo_de_saida);

  //Fecha o arquivo de saida
  fclose(ponteiro_arquivo_de_saida);
}

void escrever(FILE *ponteiro_do_arquivo) 
{
   for (int i = 0; i < NUMERO_DE_LINHAS; ++i) 
   {
     const char** linha = conteudo[i];
     const char* login = linha[0];
     const char* senha = linha[1];

     //Escreve login e senha
     fwrite(login, sizeof(char), strlen(login), ponteiro_do_arquivo);
     //espaco em branco
     fputc(' ', ponteiro_do_arquivo);
     fwrite(senha, sizeof(char), strlen(senha), ponteiro_do_arquivo);
     //Nova linha
     fputc('\n', ponteiro_do_arquivo);
   }
}
