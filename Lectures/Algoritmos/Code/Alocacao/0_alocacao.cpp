#include <iostream>

int main() 
{
	int a = 5;
	int* b = new int(5);
	
	std::cout << "a == " << a << std::endl;
	std::cout << "b == " << b << std::endl;
	std::cout << "*b == " << *b << std::endl;
	
	delete b;

	return 0;
}
