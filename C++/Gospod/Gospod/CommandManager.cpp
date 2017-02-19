#include "CommandManager.h"


CommandManager::CommandManager(Simulator *Sim){
	addressOfSimulator = Sim;
}

CommandManager::~CommandManager(){

}
						

void CommandManager::RecognizeCommand(){
	//Команда от вида add <име на планета> <entity|animal|human|god> <брой> разделена на думи по спейсове във вектор от std::string тип
	
	std::vector<std::string> tokens;
	bool running = true;

	while (running)
	{
		tokens.clear();

		std::string str;
		std::getline(std::cin, str);
		std::string buff;
		std::stringstream ss(str);



		// Записване на командата по думи
		while (ss >> buff)
		{
			tokens.push_back(buff);
		}


		if (tokens[0] == "create")
		{
			addressOfSimulator->m_player->CreatePlanet();
		}

		if (tokens[0] == "exit")
		{
			running = false;
		}

		if (tokens[0] == "update")
		{
			addressOfSimulator->Update();
		}

		if (tokens[0] == "wipeout")
		{

			addressOfSimulator->m_player->WipeOut(tokens[2]);
		}

		if (tokens[0] == "destroy")
		{

			addressOfSimulator->m_player->PlanetDestruction(tokens[2]);
		}

		if (tokens[0] == "get")
		{

			addressOfSimulator->m_player->Statistics();
		}

		if (tokens[0] == "add")
		{


			// Коя планета

			int whichPlanet;

			for (unsigned int i = 0; i < addressOfSimulator->m_player->pointerToScene->ListOfPlanets.size(); i++)
			{
				if (addressOfSimulator->m_player->pointerToScene->ListOfPlanets[i]->getName() == tokens[1])
				{
					whichPlanet = i;
				}
			}

			int exact;

			exact = whichPlanet;

			// <брой> в int
			std::stringstream numberWord;
			numberWord << tokens[3];
			int number;
			numberWord >> number;

			// Създаване на Unit-итите 

			for (int i = 0; i < number; i++)
			{
				addressOfSimulator->m_player->pointerToScene->ListOfPlanets[exact]->PushBack(addressOfSimulator->m_player->addUnits(tokens[2],addressOfSimulator));
			}
		}
	}
}