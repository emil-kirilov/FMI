#include "God.h"
#include "RG.h"


God::God(){

}

God::God(Scene* pointer){
	 pointerToScene=pointer;
	 setName(generator.generateRandomEntityName());
}

God::God(double energy, double size, double weight, double str){
	setName(generator.generateRandomEntityName());
	setEnergy(energy);
	setSize(size);
	setWeight(weight);
	setStrength(str);
	setX(generator.generateRandomNumber());
	setY(generator.generateRandomNumber());
}

God::God(double energy, double size, double weight, double str, Simulator* sim){
	addressOfSimulatorulator = sim;
	setName(generator.generateRandomEntityName());
	setEnergy(energy);
	setSize(size);
	setWeight(weight);
	setStrength(str);
	setX(generator.generateRandomNumber());
	setY(generator.generateRandomNumber());
}

God::~God(){
	delete p;
}

void God::WipeOut(std::string planetName){
	for (unsigned int i = 0; i < pointerToScene->ListOfPlanets.size(); i++)
	{
		if (pointerToScene->ListOfPlanets[i]->getName() == planetName)
		{
			pointerToScene->ListOfPlanets[i]->WipeOut();
		}
	}
}

void God::PlanetDestruction(std::string planetName){
	for (unsigned int i = 0; i < pointerToScene->ListOfPlanets.size(); i++)
	{
		if (pointerToScene->ListOfPlanets[i]->getName() == planetName)
		{
			std::cout << "Planet " << pointerToScene->ListOfPlanets[i]->getName() << " was destroyed." << std::endl << std::endl;
			pointerToScene->ListOfPlanets.erase(pointerToScene->ListOfPlanets.begin() + i);
			break;
		}
	}

}

void God::Statistics(){
	for (unsigned int i = 0; i < pointerToScene->ListOfPlanets.size(); i++)
	{
		std::cout << "There are " << pointerToScene->ListOfPlanets[i]->Population.size() << " beings on planet " << pointerToScene->ListOfPlanets[i]->getName() << "!" << std::endl;
	}
}

Entity* God::addUnits(std::string type, Simulator* address){
	
	if (type == "Entity")
	{
		Entity E(1.0, 1.0, 1.0, 1.0, address);
		addressEntity = &E;
		return addressEntity;
	}

	if (type == "Animal")
	{
		Animal A(5.0, 5.0, 5.0, 5.0, address);
		addressEntity = &A;
		return addressEntity;
	}

	if (type == "Human")
	{
		Human H(10.0, 10.0, 10.0, 10.0, address);
		addressEntity = &H;
		return addressEntity;
	}

	if (type == "God")
	{
		God G(100.0, 100.0, 100.0, 100.0, address);
		addressEntity = &G;
		return addressEntity;
	}
}


void God::CreatePlanet(){
	p = new Planet(generator.generateRandomPlanetName());
	pointerToScene->ListOfPlanets.push_back(p);
	
	std::cout << this->getName() << " created planet " << pointerToScene->ListOfPlanets.back()->getName() << '\n' << '\n';

}

void God::DoAction(){
	int randomAction;
	randomAction = rand() % 6;
	if (randomAction == 0)
		this->Move();
	if (randomAction == 1)
		this->Attack();
}