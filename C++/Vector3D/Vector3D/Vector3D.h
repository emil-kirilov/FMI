#ifndef Vector_3D
#define Vector_3D

using namespace std;

class Vector3D{
private:
	double x;
	double y;
	double z;

	void setX(double value);
	void setY(double value);
	void setZ(double value);

public:
	Vector3D();
	Vector3D(double x, double y, double z);
	~Vector3D();

	double getX() const;
	double getY() const;
	double getZ() const;

	Vector3D operator+(const Vector3D & secondVector) const;
	Vector3D operator-(const Vector3D & secondVector) const;
	Vector3D operator-() const;
	Vector3D operator*(double number) const;

	friend Vector3D operator*(double number, const Vector3D & vector);
	friend istream & operator>>(istream & iStream, Vector3D & vector);
	friend ostream & operator<<(ostream & oStream, const Vector3D & vector);


};

#endif