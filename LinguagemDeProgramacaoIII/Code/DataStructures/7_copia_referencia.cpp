#include <iostream>
#include <vector>

void imprimirVector(std::vector<int> a) 
{
	std::cout << "Tamanho do vector: " << a.size() << std::endl;
	
	for (std::vector<int>::iterator it = a.begin(); it != a.end(); ++it) 
  {
		std::cout << *it << std::endl;
	}
}

void fazAlgo(std::vector<int> a) 
{
	a[0] = 8;
}

void fazAlgo2(std::vector<int>& a) 
{
	a[0] = 8;
}

int main() 
{
	std::vector<int> v;
	v.push_back(1);
	v.push_back(3);
	v.push_back(2);
	
	imprimirVector(v);
	
	fazAlgo(v);
	imprimirVector(v);
	
	fazAlgo2(v);
	imprimirVector(v);

	return 0;
}
