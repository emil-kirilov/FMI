#ifndef Account_H
#define Account_H

#include <iostream>
#include <sstream>

class Account
{
private:
	int account_number;
	std::string name_of_the_depositer;
	char type_of_account;
	double balance_amount;
public:
	void set_values();
	void deposit_money(double);
	void withdraw_money(double);
	void print_data_members();
};

#endif