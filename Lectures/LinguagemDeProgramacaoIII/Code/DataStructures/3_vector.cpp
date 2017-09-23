#include <iostream>
#include <vector>

//Imprime todas as posicoes de um vetor
void imprimirVector(std::vector<int> a) 
{
	std::cout << "Tamanho do vector: " << a.size() << std::endl;
	
	for (std::vector<int>::iterator it = a.begin(); it != a.end(); ++it) 
  {
		std::cout << *it << std::endl;
	}
}

int main() 
{
	std::vector<int> v;
	
	imprimirVector(v);
	
	v.push_back(1);
	v.push_back(3);
	v.push_back(2);
	
	imprimirVector(v);
	
	std::cout << "v[1] == " << v[1] << std::endl;

	return 0;
}
