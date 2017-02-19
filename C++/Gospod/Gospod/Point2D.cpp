#include "Point2D.h"

void Point2D::setX(int number){
	x = number;
}

void Point2D::setY(int number){
	y = number;
}

int Point2D::getX(Point2D PointA){
	return PointA.x;
}

int Point2D::getY(Point2D PointA){
	return PointA.y;
}

double Point2D::DistanceTo(const Point2D &PointA){
	return sqrt(pow(this->x - PointA.x, 2) + pow(this->y - PointA.y, 2));
}

Point2D::Point2D(){
	setX(0);
	setY(0);
}

Point2D::Point2D(int x, int y){
	setX(x);
	setY(y);
}

Point2D::~Point2D(){

}

