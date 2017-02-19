#ifndef Human_H
#define Human_H

#include "Animal.h"

class Human :public Animal{
public:
	Human();
	Human(double energy, double size, double weight, double str);
	Human(double energy, double size, double weight, double str, Simulator*);
	~Human();

	virtual void DoAction();
};

#endif 
