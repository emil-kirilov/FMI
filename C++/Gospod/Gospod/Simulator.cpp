#include "Simulator.h"
#include "CommandManager.h"
#include "Scene.h"

Simulator::Simulator(){
	Sc = new Scene();
	m_player = new God(Sc);
	CM=new CommandManager(this);
}

Simulator::~Simulator(){
	delete CM;
	delete m_player;
	delete Sc;
}

void Simulator::Run(){
	this->Menu();
	CM->RecognizeCommand();
}

void Simulator::Menu(){
	std::cout << "Valid commands:" << '\n'
		      << "-create planet" << '\n'
		      << "-wipeout planet <planet name> " << '\n'
			  << "-destroy planet <planet name>" << '\n'
			  << "-get statistics" << '\n'
			  << "-add <planet name> <Entity|Animal|Human|God> <number>" << '\n'
			  << "-update" << '\n'
			  << "-exit" << '\n';

	
}

void Simulator::Update(){
	std::thread t1(&Simulator::Update1,this);
	t1.join();
}

void Simulator::Update1(){

	for (unsigned int i = 0; i < m_player->pointerToScene->ListOfPlanets.size(); i++)
	{
		m_player->pointerToScene->ListOfPlanets[i]->Update();
	}
}