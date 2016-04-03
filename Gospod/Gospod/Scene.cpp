#include "Scene.h"

Scene::Scene(){
	
}

Scene::~Scene(){
	for (unsigned int i = 0; i < ListOfPlanets.size();i++)
	{
		delete ListOfPlanets[i];
	}
}

void Scene::pushBack(Planet X){
	Planet* address;
	address = &X;
	ListOfPlanets.push_back(address);
}