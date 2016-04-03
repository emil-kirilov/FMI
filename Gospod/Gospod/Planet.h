#ifndef Planet_H
#define Planet_H

#include <vector>
#include <iostream>
#include <array>

#include "Entity.h"

class Planet{
public:
	std::string planetName;
	std::vector<Entity*> Population;

	void setName(std::string);
	std::string getName();

	void WipeOut();
	void PushBack(Entity*);
	void Update();

	Planet(std::string);
	Planet();
	~Planet();
};

#endif