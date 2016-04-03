#ifndef CommandManager_H
#define CommandManager_H

#include <sstream>
#include <string>
#include <iostream>
#include <vector>

#include "God.h"
#include "Simulator.h"

class CommandManager{
private:
	Simulator *addressOfSimulator;
	std::vector<std::string> tokens;

public:

	void RecognizeCommand();
	CommandManager(Simulator*);
	~CommandManager();
};

#endif