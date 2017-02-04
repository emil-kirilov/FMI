#ifndef Logic_H
#define Logic_h

#include "Board.h"
#include <cstdio>
#include <string>
#include <cstdlib>
#include <ctime>

class Logic{  
private:
	int playerFleetLife = 19;
	int pcFleetLife = 19;
	bool attackAgain = true;
	bool gameContinues = true;
	Board board;
	int shipsHit = 0;
public:
	void createShips();
	void createEnemyShips();

	
	template <typename T>
	void enemySize(T);
	
    template <typename T>
	void Size(T);

    void Attack();
	void enemyAttack();
	void enemyAttackNeaby(int, int);

private:
	void enemyAttackWithLogic();


public:
	void Start();
	void whoWon(std::string);

	Logic();
	~Logic();
};

#endif