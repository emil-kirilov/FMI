#ifndef Point2D_H
#define Point2D_H

#include <cmath>
 
class Point2D{
private:
	int x;
	int y;

public:
	void setX(int);
	void setY(int);
	int getX(Point2D);
	int getY(Point2D);

	double DistanceTo(const Point2D&);

	Point2D();
	Point2D(int, int);
	~Point2D();
};

#endif