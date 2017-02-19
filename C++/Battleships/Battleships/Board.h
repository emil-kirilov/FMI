#ifndef Board_H
#define Board_H

#include <iostream>
#include <iomanip>

class Board{
public:
	char board[10][10];
	char enemyBoard[10][10];
	char enemyBoardPlayerAttacks[10][10];

	bool isVessel[10][10];

	Board();
	~Board();
};

#endif