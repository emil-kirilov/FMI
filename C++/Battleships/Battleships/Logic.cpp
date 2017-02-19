#include "Logic.h"

Logic::Logic()
{
	srand((unsigned int)time(0));

	
}

Logic::~Logic()
{

}

void Logic::createShips()
{
	std::cout << "Enter submarine(4) coordinates(valid commands are A5A8 or A5D5):";
	Size(4);

	std::cout << "Enter submarine(4) coordinates(valid commands are A5A8 or A5D5):";
	Size(4);

	std::cout << "Enter ship(3) coordinates(valid commands are A5A7 or A5C5):";
	Size(3);

	std::cout << "Enter ship(3) coordinates(valid commands are A5A7 or A5C5):";
	Size(3);

	std::cout << "Enter ship(3) coordinates(valid commands are A5A7 or A5C5):";
	Size(3);
	
	std::cout << "Enter boat(2) coordinates(valid commands are A5A6 or A5B5):";
	Size(2);
}

void Logic::createEnemyShips()
{
	enemySize(4);
	enemySize(4);
    enemySize(3);
	enemySize(3);
	enemySize(3);
	enemySize(2);
}

template <typename T>
void Logic::Size(T size)
{
	bool noCollision = true;
	std::string temp;
	char vessel[5];
	do                                 //проверка за валиден вход и проверка дали е свободно мястото
	{
		noCollision = true;

		getline(std::cin, temp);
		strcpy_s(vessel, temp.c_str());

		if (vessel[0] == vessel[2])    //еднакви букви

		{
			if (vessel[1]>vessel[3] || vessel[1]<49 || vessel[3]>57 || vessel[3] - vessel[1] != size - 1)
			{
				noCollision = false;
				std::cout << "Invalid coordinates! Enter new coordinates:";
			}
			else
			{
				for (int row = 0; row < size; row++)
				{
					if (board.board[vessel[1] - 48 + row][(int)vessel[0] - 64] == 'O')
					{
						noCollision = false;
						std::cout << "There's a vessel! Enter new coordinates:";
						break;
					}
				}
			}

		}
		else
		{
			if (vessel[1] != vessel[3] || (int)vessel[0]>(int)vessel[2] || (int)vessel[0]<65 || (int)vessel[2]>73 || (int)vessel[2] - (int)vessel[0] != size - 1)
			{
				noCollision = false;
				std::cout << "Invalid coordinates! Enter new coordinates:";
			}
			else
			{
				for (int columns = 0; columns < size; columns++)
				{
					if (board.board[vessel[1] - 48][(int)vessel[0] - 64 + columns] == 'O')
					{
						noCollision = false;
						std::cout << "There's a vessel! Enter new coordinates:";
					}
				}
			}
		}
	} while (!noCollision);
	
	if (vessel[0] == vessel[2])    //еднакви букви
	{
		for (int row = 0; row < size; row++)
		{
			board.board[vessel[1] - 48 + row][(int)vessel[0] - 64] = 'O';
		}
	}
	else                           //различни букви
	{
		for (int columns = 0; columns < size; columns++)
		{
			board.board[vessel[1] - 48][(int)vessel[0] - 64 + columns] = 'O';
		}
	}


		//принт
	for (int i = 0; i < 10; i++)
	{
		for (int j = 0; j < 10; j++)
		{
			std::cout << std::setw(5) << board.board[i][j];
		}
		std::cout << std::endl << std::endl;
	}
}

template <typename T>
void Logic::enemySize(T size)
{
	bool noCollision = true;
	char randomLetter;
	int randomNumber;
	int horizontalOrVertical;

	do
	{
		noCollision = true;
		randomLetter = rand() % 9 + 65;
		randomNumber = rand() % 9 + 1;
		horizontalOrVertical = rand() % 2;

		if (horizontalOrVertical == 0 && (int)randomLetter < 75 - size)
		{
			for (int collumns = 0; collumns < size; collumns++)
			{
				if (board.enemyBoard[randomNumber][randomLetter - 64 + collumns] == '0')
				{
					noCollision = false;
					break;
				}
			}
		}

		else if (randomNumber <= 10 - size)
		{
			for (int rows = 0; rows < size; rows++)
			{
				if (board.enemyBoard[randomNumber + rows][randomLetter - 64] == '0')
				{
					noCollision = false;
					break;
				}
			}
		}
	} while (!noCollision);

	if (horizontalOrVertical == 0 && (int)randomLetter < 75 - size)
	{
		for (int collumns = 0; collumns < size; collumns++)
		{
			board.enemyBoard[randomNumber][randomLetter - 64 + collumns] = '0';
		}

		//принт
		//for (int i = 0; i < 10; i++)
		//{
		//	for (int j = 0; j < 10; j++)
		//	{
		//		std::cout << std::setw(5) << enemyBoard[i][j];
		//	}
		//	std::cout << std::endl << std::endl;
		//}

	}

	else if (randomNumber <= 10 - size)
	{
		for (int rows = 0; rows < size; rows++)
		{
			board.enemyBoard[randomNumber + rows][randomLetter - 64] = '0';
		}

		//принт
		///	for (int i = 0; i < 10; i++)
		//	{
		//		for (int j = 0; j < 10; j++)
		//		{
		//			std::cout << std::setw(5) << enemyBoard[i][j];
		//		}
		//		std::cout << std::endl << std::endl;
		//	}
	}

	else
	{
		this->enemySize(size);
	}

}

void Logic::Attack()
{
	std::cout << "Attack coordinates:";
	bool coordinatesNotUsedBefore = true;
	std::string temp;
	char attackPoint[3];
	do
	{
		coordinatesNotUsedBefore = true;

		getline(std::cin, temp);
		strcpy_s(attackPoint, temp.c_str());

		if (board.enemyBoardPlayerAttacks[attackPoint[1] - 48][(int)attackPoint[0] - 64] == 'x' || board.enemyBoardPlayerAttacks[attackPoint[1] - 48][(int)attackPoint[0] - 64] == '!')
		{
			std::cout << "You have already attacked there! Pick a new location!";
			coordinatesNotUsedBefore = false;
		}
	} while (!coordinatesNotUsedBefore);

	if (board.enemyBoard[attackPoint[1] - 48][(int)attackPoint[0] - 64] == '~')
	{
		board.enemyBoardPlayerAttacks[attackPoint[1] - 48][(int)attackPoint[0] - 64] = 'x';

		//принт
		for (int i = 0; i < 10; i++)
		{
			for (int j = 0; j < 10; j++)
			{
				std::cout << std::setw(5) << board.enemyBoardPlayerAttacks[i][j];
			}
			std::cout << std::endl << std::endl;
		}
	}
	else
	{
		board.enemyBoardPlayerAttacks[attackPoint[1] - 48][(int)attackPoint[0] - 64] = '!';

		//принт
		for (int i = 0; i < 10; i++)
		{
			for (int j = 0; j < 10; j++)
			{
				std::cout << std::setw(5) << board.enemyBoardPlayerAttacks[i][j];
			}
			std::cout << std::endl << std::endl;
		}

		pcFleetLife--;

		if (pcFleetLife <= 0)
		{
			whoWon("Player won!");
		}
		else
		{
			Attack();
		}
	}
	
}

void Logic::enemyAttack()
{
	char randomLetter;
	int randomNumber;
	bool coordinatesNotUsedBefore = true;
	
	do
	{
		coordinatesNotUsedBefore = true;
		randomLetter = rand() % 9 + 65;
		randomNumber = rand() % 9 + 1;

		if (board.board[randomNumber][(int)randomLetter - 64] == 'x' || board.board[randomNumber][(int)randomLetter - 64] == '!')
		{
			coordinatesNotUsedBefore = false;
		}
	} while (!coordinatesNotUsedBefore);
	
	if (board.board[randomNumber][(int)randomLetter - 64] == '~')
	{
		board.board[randomNumber][(int)randomLetter - 64] = 'x';

		//принт
		for (int i = 0; i < 10; i++)
		{
			for (int j = 0; j < 10; j++)
			{
				std::cout << std::setw(5) << board.board[i][j];
			}
			std::cout << std::endl << std::endl;
		}
	}
	else
	{
		board.board[randomNumber][(int)randomLetter - 64] = '!';

		board.isVessel[randomNumber][(int)randomLetter - 64] = true;
		shipsHit++;

		//принт
		for (int i = 0; i < 10; i++)
		{
			for (int j = 0; j < 10; j++)
			{
				std::cout << std::setw(5) << board.board[i][j];
			}
			std::cout << std::endl << std::endl;
		}

		playerFleetLife--;

		if (playerFleetLife <= 0)
		{
			whoWon("Computer won!");
			gameContinues = false;
		}
		else
		{
			attackAgain = true;
		}
	}
	
}
		
void Logic::enemyAttackWithLogic()
{
	bool attackAgain = false;
	bool alreadyAttacked = false;
	
	for (int i = 1; i < 10; i++)
	{
		for (int j = 1; j < 10; j++)
		{
			if (board.isVessel[i][j])
			{
				if (board.board[i - 1][j] != 'x' && board.board[i - 1][j] != '!' && i >= 2)
				{
					enemyAttackNeaby(i - 1, j);
					alreadyAttacked = true;
					break;
				}
				else if (board.board[i][j - 1] != 'x' && board.board[i][j - 1] != '!' && j >= 2)
				{
					enemyAttackNeaby(i, j - 1);
					alreadyAttacked = true;
					break;
				}
				else if (board.board[i + 1][j] != 'x' && board.board[i + 1][j] != '!'&& i < 9)
				{
					enemyAttackNeaby(i + 1, j);
					alreadyAttacked = true;
					break;
				}
				else if (board.board[i][j + 1] != 'x' && board.board[i][j + 1] != '!' && j < 9)
				{
					enemyAttackNeaby(i, j + 1);
					alreadyAttacked = true;
					break;
				}
				else
				{
					board.isVessel[i][j] = false;
					shipsHit--;
				}
			}
		}

		if (alreadyAttacked)
		{
			break;
		}
	}

	if (!alreadyAttacked)
	{
		enemyAttack();
	}

	if (playerFleetLife <= 0)
	{
		whoWon("Computer won!");
		gameContinues = false;
	}
}

void Logic::enemyAttackNeaby(int i, int j)
{
	if (board.board[i][j] == '~')
	{
		board.board[i][j] = 'x';

		//принт
		for (int i = 0; i < 10; i++)
		{
			for (int j = 0; j < 10; j++)
			{
				std::cout << std::setw(5) << board.board[i][j];
			}
			std::cout << std::endl << std::endl;
		}
	}
	else
	{
		board.board[i][j] = '!';
		board.isVessel[i][j] = true;
		playerFleetLife--;
		shipsHit++;
		
		//принт
		for (int i = 0; i < 10; i++)
		{
			for (int j = 0; j < 10; j++)
			{
				std::cout << std::setw(5) << board.board[i][j];
			}
			std::cout << std::endl << std::endl;
		}

		attackAgain = true;
	}
}


void Logic::Start()
{
	createShips();
	createEnemyShips();

	do
	{
		if (playerFleetLife > 0)
		{
			Attack();
		}
	
		if (gameContinues)
		{
			attackAgain = true;
		}

		while (attackAgain)
		{
			attackAgain = false;

			if (pcFleetLife > 0)
			{
				enemyAttackWithLogic();
			}
		}
		
	} while (pcFleetLife > 0 && playerFleetLife > 0);
}

void Logic::whoWon(std::string EndOfBattle)
{
	std::cout << EndOfBattle << std::endl;
}