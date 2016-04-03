#include <iostream>

#include "Vector3D.h"

using namespace std;

int main(){
	Vector3D vector1, vector2;

	cout << "Vector 1: " << '\n';
	cin >> vector1;
	cout << "Vector 2: " << '\n';
	cin >> vector2;

	cout << "Vector 1 + Vector 2 = " << vector1 + vector2;


	cout << endl;

	system("pause");
	return 0;
}