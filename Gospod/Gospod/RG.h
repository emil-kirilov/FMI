#ifndef RG_H
#define RG_H

#include <string>
#include <vector>
#include <cstdlib>
#include <ctime>
#include <iostream>

 

class RG{
private:
    void fillNumbers();
	void fillNamesOfPlanets();
	void fillNamesOfEntities();
public:
	 std::vector<int> Numbers;
	 std::vector<std::string> NamesOfPlanets;
	 std::vector<std::string> NamesOfEntities;


	 int generateRandomNumber();
	 std::string generateRandomEntityName();
	 std::string generateRandomPlanetName();


	RG();
	~RG();

};

#endif 
