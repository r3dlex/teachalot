#include <iostream>

class A 
{
public:
	A() 
  { std::cout << "A criado" << std::endl; }

	~A() 
  { std::cout << "A destruido" << std::endl; }
	
	void dizerOla() 
  {
		std::cout << "Ola" << std::endl;
	}
};

int main() 
{
	A* a = new A();
	
	std::cout << "a == " << a << std::endl;
	
	(*a).dizerOla();
	a->dizerOla();
	
	delete a;

	return 0;
}
