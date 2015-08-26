#include <iostream>

int main() 
{
	std::string nome("Uma gr4nde gafe!");
	
	for (int i = 6; i >= 0; --i) 
  {
		std::cout << nome[i];
	}
	
	std::cout << std::endl;
	
	nome[6] = 'a';
	
	std::cout << nome << std::endl;

	return 0;
}
