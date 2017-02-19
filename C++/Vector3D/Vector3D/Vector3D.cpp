#include <iostream>
#include <string>
#include <sstream>

#include "Vector3D.h"


void Vector3D::setX(double value)
{
	x = value;
}

void Vector3D::setY(double value)
{
	y = value;
}

void Vector3D::setZ(double value)
{
	z = value;
}

double Vector3D::getX() const
{
	return x;
}

double Vector3D::getY() const
{
	return y;
}

double Vector3D::getZ() const
{
	return z;
}
Vector3D::Vector3D()
{
	setX(0);
	setY(0);
	setZ(0);
}

Vector3D::~Vector3D()
{

}

Vector3D::Vector3D(double x, double y, double z)
{
	setX(x);
	setY(y);
	setZ(z);
}


Vector3D Vector3D::operator+(const Vector3D & secondVector) const
{
	double x = this->getX() + secondVector.x;
	double y = this->getY() + secondVector.y;
	double z = this->getZ() + secondVector.z;
	return Vector3D(x, y, z);
}

Vector3D Vector3D::operator-(const Vector3D & secondVector) const
{
	double x = this->getX() - secondVector.x;
	double y = this->getY() - secondVector.y;
	double z = this->getZ() - secondVector.z;
	return Vector3D(x, y, z);
}

Vector3D Vector3D::operator-() const
{
	double x = -(this->x);
	double y = -(this->x);
	double z = -(this->x);
	return Vector3D(x, y, z);
}

Vector3D Vector3D::operator*(double number) const
{
	double x = this->getX()*number;
	double y = this->getY()*number;
	double z = this->getZ()*number;
	return Vector3D(x, y, z);
}

Vector3D operator*(double number, const Vector3D & vector){	double x = number*vector.x;	double y = number*vector.y;	double z = number*vector.z;	return Vector3D(x, y, z);}ostream & operator<< (ostream & oStream, const Vector3D & vector)
{
	oStream << "(" << vector.x << "," << vector.y << "," << vector.z << ")";
	return oStream;
}

istream & operator>> (istream & iStream, Vector3D & vector)
{
	{
		string s;
		getline(cin, s, ',');
		istringstream(s.substr(0, s.size())) >> vector.x;

		getline(cin, s, ',');
		istringstream(s.substr(0, s.size())) >> vector.y;

		getline(cin, s, ')');
		istringstream(s.substr(0, s.size())) >> vector.z;

		cin.clear();
		return (std::istream &)vector;
		fflush(stdin);
	}
}