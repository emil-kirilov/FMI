#include "Entity.h"
#include "SingleGenerator.h"
#include "God.h"

void Entity::setName(std::string value){
	name = value;
}

void Entity::setEnergy(double value){
	energy = value;
}

void Entity::setSize(double value){
	size = value;
}

void Entity::setWeight(double value){
	weight = value;
}

void Entity::setStrength(double value){
	strength = value;
}

void Entity::setX(int value){
	Position.setX(value);
}

void Entity::setY(int value){
	Position.setY(value);
}

std::string Entity::getName(){
	return name;
}

double Entity::getEnergy(){
	return energy;
}

double Entity::getSize(){
	return size;
}

double Entity::getWeight(){
	return weight;
}

double Entity::getStrength(){
	return strength;
}

int Entity::getX(){
	return Position.getX(Position);
}

int Entity::getY(){
	return Position.getY(Position);
}

RG Entity::generator;

Entity::Entity(){
	
}

Entity::Entity(double energy, double size, double weight, double str, Simulator* sim){
	addressOfSimulatorulator = sim;
	setName(generator.generateRandomEntityName());
	setEnergy(energy);
	setSize(size);
	setWeight(weight);
	setStrength(str);
	setX(generator.generateRandomNumber());
	setY(generator.generateRandomNumber());
}

Entity::Entity(double energy, double size, double weight, double str){
	setName(generator.generateRandomEntityName());
	setEnergy(energy);
	setSize(size);
	setWeight(weight);
	setStrength(str);
	setX(generator.generateRandomNumber());
	setY(generator.generateRandomNumber());
}

Entity::~Entity(){

}

double Entity::Attack(Entity *Enemy){
	if (Enemy->energy > 0)
	{
		Enemy->energy -= this->strength;
		return Enemy->energy;
		

	}
}

void Entity::Attack(){
	for (unsigned int i = 0; i < addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population.size(); i++)
	{
		
		if ((this->getX() == addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population[i]->getX() - 1 || this->getX() == addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population[i]->getX() + 1) &&
			(this->getY() == addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population[i]->getY() - 1 || this->getY() == addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population[i]->getY() + 1))
		{	
			double health;
			health = this->Attack(addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population[i]);
			if (health<=0)
			{
				addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population.erase(addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population.begin() + i);
			}
			else
			{
				addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population[i]->setEnergy(health);
			}
			
				
		}
	}
}

void Entity::Move(){
	int x = generator.generateRandomNumber();
	int y = generator.generateRandomNumber();
	
	for (unsigned int i = 0; i < addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population.size(); i++)
	{
		if (x == addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population[i]->getX() && y == addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population[i]->getY())
		{
			this->setEnergy(this->getEnergy() + addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population[i]->getEnergy());
			this->setEnergy(this->getSize() + addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population[i]->getSize());
			this->setEnergy(this->getStrength() + addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population[i]->getStrength());
			this->setEnergy(this->getWeight() + addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population[i]->getWeight());
			addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population.erase(addressOfSimulatorulator->m_player->pointerToScene->ListOfPlanets[whichPlanet]->Population.begin() + i);
			break;
		}
	}
	this->setX(x);
	this->setY(y);
}

void Entity::DoAction(){
	int randomAction;
	randomAction = rand() % 2;
	if (randomAction == 0)
	{
		this->Move();
		std::cout << this->getName() << " moved." << std::endl;
	}
	else
	{
		this->Attack();
		std::cout << this->getName() << " tried to attack nearby enemy." << std::endl;
	}
}
