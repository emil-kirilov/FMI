#ifndef God_H
#define GOd_H

#include "Human.h"
#include "Planet.h"
#include "RG.h"
#include "Scene.h"

#include <sstream>

class God :public Human{
public:
	Scene* pointerToScene;
	Entity* addressEntity;
	Planet* p;

	void CreatePlanet();
	void Statistics();
	Entity* addUnits(std::string, Simulator*);

	void WipeOut(std::string);
	void PlanetDestruction(std::string);

	void DoAction();

	God();
	God(Scene*);
	God(double energy, double size, double weight, double str);
	God(double energy, double size, double weight, double str, Simulator*);
	~God();
};
#endif 
