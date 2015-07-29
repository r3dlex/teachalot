/* Inclui a definição do livro */
#include "livro.h"

#include <string.h>
#include <stdio.h>

void imprimirLivro(struct Livro* livro) {
   printf( "====Livro====\n");
   printf( "Titulo: %s\n", livro->titulo);
   printf( "Autor: %s\n", livro->autor);
   printf( "Assunto: %s\n", livro->assunto);
   printf( "Id: %d\n", livro->id);
   printf( "=============\n");
}

int main()
{
   struct Livro livro1; 
   struct Livro livro2;
 
   /* Especificação do livro 1 */
   strcpy(livro1.titulo, "A Guerra dos Tronos");
   strcpy(livro1.autor, "George R Martin"); 
   strcpy(livro1.assunto, "Fantasia");
   livro1.id = 3121;

   /* Especificação do livro 2 */
   strcpy(livro2.titulo, "Senhor dos Aneis");
   strcpy(livro2.autor, "J R R Tolkien");
   strcpy(livro2.assunto, "Fantasia");
   livro2.id = 95021;
 
   imprimirLivro(&livro1);
   imprimirLivro(&livro2);

   return 0;
}
