#ifndef Animal_H
#define Animal_H

#include "Entity.h"

class Animal :public Entity{
public:
	Animal();
   
	Animal(double energy, double size, double weight, double str);
	Animal(double energy, double size, double weight, double str, Simulator*);
	~Animal();

	virtual void DoAction();
};

#endif 
