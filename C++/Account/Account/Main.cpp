#include "Account.h""

int main()
{
	Account A;
	A.set_values();
	A.deposit_money(300.0);
	A.withdraw_money(200.0);
	A.print_data_members();

	system("pause");
	return 0;
}