#include "Animal.h"

Animal::Animal(){

}

Animal::Animal( double energy, double size, double weight, double str){
	setName(generator.generateRandomEntityName());
	setEnergy(energy);
	setSize(size);
	setWeight(weight);
	setStrength(str);
	setX(generator.generateRandomNumber());
	setY(generator.generateRandomNumber());
}

Animal::Animal(double energy, double size, double weight, double str, Simulator* sim){
	addressOfSimulatorulator = sim;
	setName(generator.generateRandomEntityName());
	setEnergy(energy);
	setSize(size);
	setWeight(weight);
	setStrength(str);
	setX(generator.generateRandomNumber());
	setY(generator.generateRandomNumber());
}

Animal::~Animal(){

}

void Animal::DoAction(){
	int randomAction;
	randomAction = rand() % 5;
	if (randomAction == 0)
		this->Move();
	if (randomAction == 1)
		this->Attack();
}
