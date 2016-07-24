#include <iostream>
#include <list>

//Imprime todos os elementos de uma lista
void imprimirLista(std::list<int> lista) 
{
	std::cout << "Tamanho da lista: " << lista.size() << std::endl;
	
  //Um iterador eh um padrao de projeto!
	for (std::list<int>::iterator it = lista.begin(); it != lista.end(); ++it) 
  {
		std::cout << *it << std::endl;
	}
}

int main() 
{
	std::list<int> lista;
	
	imprimirLista(lista);
	
	lista.push_back(1);
	lista.push_back(3);
	lista.push_front(2);
	
	imprimirLista(lista);

	return 0;
}
