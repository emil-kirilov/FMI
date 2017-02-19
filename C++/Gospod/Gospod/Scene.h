#ifndef Scene_H
#define Scene_H

#include "Planet.h"

#include <vector>

class Scene{
public:
	void pushBack(Planet);

	std::vector<Planet*> ListOfPlanets;
	

	Scene();
	~Scene();
	
};



#endif