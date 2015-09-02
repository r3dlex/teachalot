#include <iostream>

class Veiculo 
{
public:
	Veiculo(const std::string& _placa, unsigned _numeroDeRodas)
		: _placa(_placa), _numeroDeRodas(_numeroDeRodas)
	{ }
	
	const std::string& getPlaca() const 
  {
		return _placa;
	}
	
	unsigned getNumeroDeRodas() const 
  {
		return _numeroDeRodas;
	}
	
	void imprimirInfo() const 
  {
		std::cout << "Placa: " << _placa << std::endl;
		std::cout << "Rodas: " << _numeroDeRodas << std::endl;
	}

private:
	std::string _placa;
	unsigned _numeroDeRodas;
};

class Moto : public Veiculo 
{
public:
	Moto(const std::string& _placa)
		: Veiculo(_placa, 2u)
	{ }
};

class Carro : public Veiculo 
{
public:
	Carro(const std::string& _placa)
		: Veiculo(_placa, 4u)
	{ }
};

int main() 
{
	Carro a("MFB5714");
	Moto b("AJB2012");
	
	a.imprimirInfo();
	b.imprimirInfo();
	
	return 0;
}
