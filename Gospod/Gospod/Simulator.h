#ifndef Simulator_H
#define Simulator_H


#include <thread>
#include <iostream>

class Simulator{
private:
   void Menu();
public:	
    class God *m_player;
    class CommandManager *CM;
	class Scene *Sc;

	void Update();
	void Update1();
	void Run();

	Simulator();
	~Simulator();

};
#endif 
