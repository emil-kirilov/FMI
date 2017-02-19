#include "Account.h"

void Account::set_values()
{
	std::cout << "Please enter your account number" << std::endl;
	int acc_number;
	std::cin >> acc_number;
	account_number = acc_number;

	std::cout << "Please enter your name" << std::endl;
	std::string name;
	std::cin >> name;
	name_of_the_depositer = name;

	std::cout << "Please enter your account type ('S' for savings and 'C' for checking)" << std::endl;
	char type;
	std::cin >> type;
	type_of_account = type;

	std::cout << "Please enter your account balance" << std::endl;
	double balance;
	std::cin >> balance;
	balance_amount = balance;
}

void Account::deposit_money(double amountToDeposit)
{
	balance_amount += amountToDeposit;
	std::cout << "Your balance is " << balance_amount << " ." << std::endl;
}

void Account::withdraw_money(double amountToWithdraw)
{
	if (balance_amount > 500.0 + amountToWithdraw)
	{
		balance_amount -= amountToWithdraw;

		std::cout << amountToWithdraw << std::endl;
	}
	else if (balance_amount > 500.0)
	{
		double money_withdrawn;
		money_withdrawn = balance_amount - 500.0;
		balance_amount -= money_withdrawn;
		std::cout << money_withdrawn << std::endl;
	}
	else
	{
		std::cout << "0" << std::endl;
	}

}

void Account::print_data_members()
{
	std::cout << "Account number is " << account_number << " ." << std::endl;
	std::cout << "Name of the depositer is " << name_of_the_depositer << " ." << std::endl;
	std::cout << "Type of account is " << type_of_account << " ." << std::endl;
	std::cout << "Balance amount is " << balance_amount << " ." << std::endl;
}

