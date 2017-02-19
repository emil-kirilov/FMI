#include "Planet.h"

Planet::Planet(std::string name){
	setName(name);
}

Planet::Planet(){

}

Planet::~Planet(){

}

void Planet::WipeOut(){
	Population.clear();
	std::cout << "All creatures on planet " << this->getName() << " have been killed!" << '\n' << '\n';
}

void Planet::setName(std::string name){
	planetName = name;
}

std::string Planet::getName(){
	return planetName;
}

void Planet::PushBack(Entity* X){
	Population.push_back(X);
}


void Planet::Update(){
	for (unsigned int i = 0; i < Population.size(); i++)
	{
		Population[i]->DoAction();
	}
}