#include "Human.h"

Human::Human() {
}
	

Human::Human(double energy, double size, double weight, double str){
	setName(generator.generateRandomEntityName());
	setEnergy(energy);
	setSize(size);
	setWeight(weight);
	setStrength(str);
	setX(generator.generateRandomNumber());
	setY(generator.generateRandomNumber());
}

Human::Human(double energy, double size, double weight, double str, Simulator* sim){
	addressOfSimulatorulator = sim;
	setName(generator.generateRandomEntityName());
	setEnergy(energy);
	setSize(size);
	setWeight(weight);
	setStrength(str);
	setX(generator.generateRandomNumber());
	setY(generator.generateRandomNumber());
}


Human::~Human(){

}

void Human::DoAction(){
	int randomAction;
	randomAction = rand() % 6;
	if (randomAction == 0)
		this->Move();
	if (randomAction == 1)
		this->Attack();
}