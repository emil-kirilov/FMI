#include "CommandManager.h"


CommandManager::CommandManager(Simulator *Sim){
	addressOfSimulator = Sim;
}

CommandManager::~CommandManager(){

}
						

void CommandManager::RecognizeCommand(){
	//������� �� ���� add <��� �� �������> <entity|animal|human|god> <����> ��������� �� ���� �� �������� ��� ������ �� std::string ���
	
	std::vector<std::string> tokens;
	bool running = true;

	while (running)
	{
		tokens.clear();

		std::string str;
		std::getline(std::cin, str);
		std::string buff;
		std::stringstream ss(str);



		// ��������� �� ��������� �� ����
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


			// ��� �������

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

			// <����> � int
			std::stringstream numberWord;
			numberWord << tokens[3];
			int number;
			numberWord >> number;

			// ��������� �� Unit-����� 

			for (int i = 0; i < number; i++)
			{
				addressOfSimulator->m_player->pointerToScene->ListOfPlanets[exact]->PushBack(addressOfSimulator->m_player->addUnits(tokens[2],addressOfSimulator));
			}
		}
	}
}