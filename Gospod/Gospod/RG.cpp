#include "RG.h"

RG::RG(){
	srand(time(0));

	fillNumbers();
	fillNamesOfPlanets();
	fillNamesOfEntities();
}

RG::~RG(){

}

void RG::fillNumbers(){
	Numbers.resize(100);
	for (unsigned int i = 0; i < 100; i++)
	{
		Numbers[i] = i;
	}

}


void RG::fillNamesOfPlanets(){
	std::vector<std::string> ListOfNames = { 
		"Mercury",
		"Venus",
		"Earth",
		"Mars",
		"Jupiter",
		"Saturn",
		"Uranus",
		"Neptune",
		"Pluto",
		"Ucriumia",
		"Ecliocury",
		"Oshov",
		"Jascao",
		"Woynope",
		"Louyama",
		"Whabatania",
		"Strodugawa",
		"Skiuq",
		"Drara",
		"Yudraoria",
		"Yebroyama",
		"Etriea",
		"Pochilles",
		"Jieliv",
		"Hiynides",
		"Thabucury",
		"Drufumia",
		"Cragua",
		"Stinda",
		"Ceflainerth",
		"Sowhuiphus",
		"Vutragua",
		"Tobrides",
		"Ruenides",
		"Mayrilia",
		"Shufegantu",
		"Smecophus",
		"Driea",
		"Drone",
		"Basmoinides",
		"Iedriavis",
		"Vestrars",
		"Gutrolla",
		"Totov",
		"Guynov",
		"Skodunus",
		"Whodaliv",
		"Floth",
		"Whagua",
		"Mubruicarro",
		"Lubreilea",
		"Kasluna",
		"Nashagua",
		"Ceyruta",
		"Bouria",
		"Flaboter",
		"Spabulara",
		"Swion",
		"Swov"
	};
	NamesOfPlanets.resize(59);
	NamesOfPlanets.swap(ListOfNames);
}


void RG::fillNamesOfEntities(){
	std::vector<std::string> ListOfNames = { 
		"Anthony",
		"Darnell",
		"Spencer",
		"Devin",
		"Roger",
		"Nick",
		"Jesse",
		"Arthur",
		"Logan",
		"Xavier",
		"Matthew",
		"Stanton",
		"Sean",
		"Jake",
		"Rosendo",
		"Mitch",
		"Noel",
		"Melvin",
		"Garfield",
		"Wes",
		"Glen",
		"Gus",
		"Darren",
		"Emerson",
		"Fidel",
		"Randell",
		"Gustavo",
		"Dallas",
		"Kareem",
		"Domenic",
		"Sylvester",
		"Ron",
		"Ariel",
		"Nathaniel",
		"Jewel",
		"Ronald",
		"Clair",
		"Ahmed",
		"Dale",
		"Chauncey",
		"Jamey",
		"Josh",
		"Rodrigo",
		"Israel",
		"Stefan",
		"Johnnie",
		"Arron",
		"Lupe",
		"Hosea",
		"Chris",
		"Charlesetta",
		"Takisha",
		"Shalanda",
		"Albertina",
		"Camelia",
		"Clementine",
		"Piedad",
		"Angelena",
		"Phylicia",
		"Ester",
		"Amee",
		"Chastity",
		"Pasty",
		"Meridith",
		"Melanie",
		"Alla",
		"Paula",
		"Zandra",
		"Elenore",
		"Lisbeth",
		"Zofia",
		"Porsche",
		"Danika",
		"Onita",
		"Niesha",
		"Christine",
		"Josefine",
		"Deloris",
		"Natasha",
		"Divina",
		"Fallon",
		"Eboni",
		"Doretha",
		"Raisa",
		"Shiloh",
		"Mirna",
		"Albertha",
		"Elise",
		"Kera",
		"Gillian",
		"Shin",
		"Skye",
		"Jayne",
		"Verlene",
		"Muriel",
		"Lizeth",
		"Violette",
		"Eloise",
		"Romona",
		"Tammera"
	};
	NamesOfEntities.resize(100);
	NamesOfEntities.swap(ListOfNames);
}

int RG::generateRandomNumber(){
	int positionInvector;
	positionInvector = rand() % 100;

	return positionInvector;
}

std::string RG::generateRandomEntityName(){
	int positionInvector;
	positionInvector = rand() % NamesOfEntities.size();

	std::string name;
	name = NamesOfEntities[positionInvector];

	if (positionInvector == 0)
	{
		NamesOfEntities.erase(NamesOfEntities.begin());
	}
	else
	{
		NamesOfEntities.erase(NamesOfEntities.begin() + positionInvector - 1);
	}
   
	return name;
}

std::string RG::generateRandomPlanetName(){
	int positionInvector;
	positionInvector = rand() % NamesOfPlanets.size();

	std::string name;
	name = NamesOfPlanets[positionInvector];

	if (positionInvector == 0)
	{
		NamesOfPlanets.erase(NamesOfPlanets.begin());
	}
	else
	{
		NamesOfPlanets.erase(NamesOfPlanets.begin() + positionInvector - 1);
	}

	return name;
}
