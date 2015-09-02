#include <iostream>

class Veiculo 
{
public:
	Veiculo(const std::string& placa, unsigned numeroDeRodas)
		: placa(placa), numeroDeRodas(numeroDeRodas)
	{ }
	
	const std::string& getPlaca() const 
  {
		return placa;
	}
	
	unsigned getNumeroDeRodas() const 
  {
		return numeroDeRodas;
	}
	
	void imprimirInfo() const 
  {
		std::cout << "Placa: " << placa << std::endl;
		std::cout << "Rodas: " << numeroDeRodas << std::endl;
	}

private:
	std::string placa;
	unsigned numeroDeRodas;
};

class Moto : public Veiculo 
{
public:
	Moto(const std::string& placa)
		: Veiculo(placa, 2u)
	{ }
};

class Carro : public Veiculo 
{
public:
	Carro(const std::string& placa)
		: Veiculo(placa, 4u)
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
