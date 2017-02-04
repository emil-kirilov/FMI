#ifndef Entity_H
#define Entity_H

#include "Point2D.h"
#include "SingleGenerator.h"
#include "Simulator.h"


#include <string>
#include <iostream>
#include <cstdlib>

 

class  Entity{
protected:
	Simulator *addressOfSimulatorulator;
	int whichPlanet;

	std::string name;
	double energy;
	double size;
	double weight;
	double strength;

	Point2D Position;
	static RG generator;

	void setName(std::string);
	void setEnergy(double);
	void setSize(double);
	void setWeight(double);
	void setStrength(double);
	void setX(int);
	void setY(int);

public:
	virtual enum State
	{
		Moving, Attacking
	};

	std::string getName();
	double getEnergy();
	double getSize();
	double getWeight();
	double getStrength();
	int getX();
	int getY();
	void getState();

    double Attack(Entity*);
    void Attack();
	void Move();
	virtual void DoAction(); 

    void getsize();

	Entity();
	Entity(double energy, double size, double weight, double str);
	Entity(double energy, double size, double weight, double str, Simulator*);
	~Entity();
};


#endif 
