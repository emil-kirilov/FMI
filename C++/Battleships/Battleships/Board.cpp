#include "Board.h"

Board::Board()
{   //������� ������ �� ������
	board[0][0] = ' ';

	for (int i = 1; i < 10; i++)
	{
		board[0][i] = i + 64;
	}

	for (int i = 1; i < 10; i++)
	{
		board[i][0] = i + 48;
	}

	for (int i = 1; i < 10; i++)
	{
		for (int j = 1; j < 10; j++)
		{
			board[i][j] = '~';
		}
	}

	//������� ������ �� �����
	enemyBoard[0][0] = ' ';

	for (int i = 1; i < 10; i++)
	{
		enemyBoard[0][i] = i + 64;
	}

	for (int i = 1; i < 10; i++)
	{
		enemyBoard[i][0] = i + 48;
	}

	for (int i = 1; i < 10; i++)
	{
		for (int j = 1; j < 10; j++)
		{
			enemyBoard[i][j] = '~';
		}
	}

	//������� ������ ����� ������� �������
	enemyBoardPlayerAttacks[0][0] = ' ';

	for (int i = 1; i < 10; i++)
	{
		enemyBoardPlayerAttacks[0][i] = i + 64;
	}

	for (int i = 1; i < 10; i++)
	{
		enemyBoardPlayerAttacks[i][0] = i + 48;
	}

	for (int i = 1; i < 10; i++)
	{
		for (int j = 1; j < 10; j++)
		{
			enemyBoardPlayerAttacks[i][j] = '~';
		}
	}

	//������ false ���������
	for (int i = 0; i < 10; i++)
	{
		for (int j = 0; j < 10; j++)
		{
			isVessel[i][j] = false;

		}
	}
}

Board::~Board()
{

}