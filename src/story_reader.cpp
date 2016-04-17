/*
 * This file is part of Story Teller.
 *
 * Copyright © 2016 Robin Lamarche-Perrin, Régis Catinaud
 * (<Robin.Lamarche.Perrin@gmail.fr>)
 * 
 * Story Teller is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the Free
 * Software Foundation, either version 3 of the License, or (at your option)
 * any later version.
 * 
 * Story Teller is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
 * or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 * 
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */



#include <cstdlib>
#include <iostream>
#include <sys/time.h>

#include <list>
#include <set>
#include <map>
#include <vector>
#include <string>
using std::string;

#include "tinyxml.h"


const TiXmlElement *getElement (const TiXmlElement *root, string value, string attribute, string id);
void executeContent (const TiXmlElement *content);

void error (const TiXmlElement *element, string text);
bool testValue (const TiXmlElement *element, string value);
bool testAttribute (const TiXmlElement *element, string attribute);
bool testChild (const TiXmlElement *element, string child);

bool end = false;
std::map<string,string> types;
std::map<string,bool> binaries;
std::map<string,int> counters;

int main (int argc, char *argv[])
{
	srand (time(NULL));

	string filename = "";
    if (argc > 1) { filename = argv[1]; }
	else { std::cerr << "Error: Input file not specified" << std::endl; }
	
	// OPEN FILE
	TiXmlDocument document (filename.c_str());
	if (!document.LoadFile()) { std::cerr << "Error: Failed to load file " << filename << std::endl; }

	// START NARRATION
	const TiXmlElement *narration = document.RootElement ();
	testValue(narration,"NARRATION");
	testAttribute(narration,"START");
	const TiXmlElement *situation = getElement(narration, "SITUATION", "ID", narration->Attribute("START"));
	
	std::cout << "--- L'AVENTURE COMMENCE ---" << std::endl;

	while (!end)
	{
		string situationId = situation->Attribute("ID");
		//std::cout << situationId << std::endl;

		// EXECUTE SITUATION
		const TiXmlNode *nContent = situation->FirstChild("CONTENT");
		if (nContent != NULL) { executeContent(nContent->ToElement()); }
		if (end) { continue; }
		
		// GET TRANSITIONS
		std::list<const TiXmlElement *> transitions;
		for (const TiXmlNode *nTransition = narration->FirstChild("TRANSITION"); nTransition; nTransition = nTransition->NextSibling("TRANSITION"))
		{
			const TiXmlElement *transition = nTransition->ToElement();
			
			testAttribute(transition,"FROM");
			if (transition->Attribute("FROM") == situationId)
			{
				// CHECK CONDITIONS
				bool verified = true;
				for (const TiXmlNode *nCondition = transition->FirstChild("CONDITION"); nCondition && verified; nCondition = nCondition->NextSibling("CONDITION"))
				{
					const TiXmlElement *condition = nCondition->ToElement();

					testChild(condition,"TEST");
					const TiXmlElement *test = condition->FirstChild("TEST")->ToElement();

					testAttribute(test,"VARIABLE");
					string variable = test->Attribute("VARIABLE");

					testAttribute(test,"COMP");
					string comp = test->Attribute("COMP");

					if (types.find(variable) == types.end()) { error (test, "this variable does not exists"); }

					if (types[variable] == "binary")
					{
						testAttribute(test,"VALUE");
						string valueStr = test->Attribute("VALUE");
			
						bool boolValue;
						if (valueStr == "true") { boolValue = true; }
						else if (valueStr == "false") { boolValue = false; }
						else { error (test, "VALUE should be 'true' or 'false'"); }

						if (comp == "eq") { verified = (binaries[variable] == boolValue); }
						else if (comp == "neq") { verified = (binaries[variable] != boolValue); }
						else { error (test, "COMP unknown"); }
					}

					else if (types[variable] == "counter")
					{
						int v;
						testAttribute(test,"VALUE");
						test->Attribute("VALUE", &v);

						if (comp == "eq") { verified = (counters[variable] == v); }
						else if (comp == "neq") { verified = (counters[variable] >= v); }
						else if (comp == "leq") { verified = (counters[variable] <= v); }
						else if (comp == "geq") { verified = (counters[variable] != v); }
						else { error (test, "COMP unknown"); }						
					}

					else { error (test, "this variable does not exists"); }
				}
				
				if (verified) { transitions.push_back(transition); }
			}
		}

		
		if (!transitions.empty())
		{
			const TiXmlElement *transition = NULL;

			// GET PRIORITIES
			std::set<int> priorities;
			for (std::list<const TiXmlElement *>::iterator it = transitions.begin(); it != transitions.end(); ++it)
			{
				const TiXmlElement *transition = *it;
				const TiXmlNode *priority = transition->FirstChild("PRIORITY");
				if (priority != NULL) { priorities.insert(std::atoi(priority->ToElement()->GetText())); }
				else { priorities.insert(0); }
			}

			int currentPriority = *(priorities.rbegin());
			
			// ITERATE THROUGH TRANSITIONS
			int choiceNum = 0;
			std::map<int,const TiXmlElement *> choices;

			int probSum = 0;
			std::vector<int> prob;
			int probabilityNum = 0;
			std::map<int,const TiXmlElement *> probabilities;

			for (std::list<const TiXmlElement *>::iterator it = transitions.begin(); it != transitions.end(); ++it)
			{
				const TiXmlElement *transition = *it;

				// CHECK PRIORITY
				const TiXmlNode *priority = transition->FirstChild("PRIORITY");
				if (priority != NULL)
				{
					if (currentPriority != std::atoi(priority->ToElement()->GetText())) { continue; }
				}
				else if (currentPriority != 0) { continue; }

				// GET CHOICES
				const TiXmlNode *choice = transition->FirstChild("CHOICE");
				if (choice != NULL)
				{
					std::cout << "(" << choiceNum << ") " << choice->ToElement()->GetText() << " ";
					choices.insert(std::pair<int,const TiXmlElement *>(choiceNum,transition));
					choiceNum++;
				}

				// GET PROBABILITIES
				else {
					const TiXmlNode *probability = transition->FirstChild("PROBABILITY");

					int p = 100;
					if (probability != NULL) { p = std::atoi(probability->ToElement()->GetText()); }

					prob.push_back(p);
					probSum += p;
					probabilities.insert(std::pair<int,const TiXmlElement *>(probabilityNum,transition));
					probabilityNum++;
				}
			}

			// SELECT TRANSITION
			if (choiceNum > 0)
			{
				std::cout << "CHOIX = ";
				int num;
				std::cin >> num;
				std::cout << std::endl;
				transition = choices[num];
			}

			else {
				int r = rand() % probSum + 1;
				int num = 0;

				while (r > prob[num]) { r -= prob[num++]; }				
				transition = probabilities[num];
			}


			// EXECUTE TRANSITION
			const TiXmlNode *nContent = transition->FirstChild("CONTENT");
			if (nContent != NULL) { executeContent(nContent->ToElement()); }
			if (end) { continue; }

			testAttribute(transition,"TO");
			situation = getElement(narration, "SITUATION", "ID", transition->Attribute("TO"));
		}
		
		else { error (situation, "No transition available"); }
	}

	return EXIT_SUCCESS;
}


const TiXmlElement *getElement (const TiXmlElement *element, string value, string attribute, string id)
{
	const TiXmlNode *node;
	for (node = element->FirstChild(value.c_str()); node; node = node->NextSibling(value.c_str()))
	{
		if (node->ToElement()->Attribute(attribute.c_str()) == id) { return node->ToElement(); }
	}

	error (element, "could not find element " + value + " with attribute " + attribute + " equal to " + id);
	return NULL;
}


void executeContent (const TiXmlElement *content)
{
	bool printedText = false;
	for (const TiXmlNode *node = content->FirstChild(); node; node = node->NextSibling())
	{
		const TiXmlElement *element = node->ToElement();
		TiXmlString value = element->ValueTStr();
		
		// PRINT TEXT
		if (value == "PRINT") { std::cout << element->GetText() << std::endl; printedText = true; }

		// START OR END NEW NARRATION
		else if (value == "END") { std::cout << "--- FIN DE L'AVENTURE ---" << std::endl; end = true; }

		// CREATE VARIABLES
		else if (value == "VARIABLE")
		{
			testAttribute(element,"ID");
			string id = element->Attribute("ID");

			testAttribute(element,"TYPE");
			string type = element->Attribute("TYPE");

			if (types.find(id) != types.end()) { error (element, "this variable already exists"); }
			types.insert(std::pair<string,string>(id,type));

			if (type == "binary")
			{
				testAttribute(element,"INIT_VALUE");
				string valueStr = element->Attribute("INIT_VALUE");
			
				bool boolValue;
				if (valueStr == "true") { boolValue = true; }
				else if (valueStr == "false") { boolValue = false; }
				else { error (element, "INIT_VALUE should be 'true' or 'false'"); }
			
				binaries.insert(std::pair<string,bool>(id,boolValue));
			}

			else if (type == "counter")
			{
				int intValue;
				testAttribute(element,"INIT_VALUE");
				element->Attribute("INIT_VALUE", &intValue);
				counters.insert(std::pair<string,int>(id,intValue));
			}

			else { error (element, "unknown TYPE"); }
		}

		// MODIFY VARIABLES
		else if (value == "SET" || value == "ADD" || value == "SUB" || value == "MUL" || value == "DIV")
		{
			testAttribute(element,"VARIABLE");
			string variable = element->Attribute("VARIABLE");

			if (types.find(variable) == types.end()) { error (element, "this variable does not exists"); }
			
			if (types[variable] == "counter")
			{
				int intValue;
				testAttribute(element,"VALUE");
				element->Attribute("VALUE", &intValue);

				if (value == "SET") { counters[variable] = intValue; }
				if (value == "ADD") { counters[variable] += intValue; }
				if (value == "SUB") { counters[variable] -= intValue; }
				if (value == "MUL") { counters[variable] *= intValue; }
				if (value == "DIV") { counters[variable] /= intValue; }
			}

			else if (types[variable] == "binary")
			{
				testAttribute(element,"VALUE");
				string valueStr = element->Attribute("VALUE");
			
				bool boolValue;
				if (valueStr == "true") { boolValue = true; }
				else if (valueStr == "false") { boolValue = false; }
				else { error (element, "VALUE should be 'true' or 'false'"); }
			
				if (value == "SET") { binaries[variable] = boolValue; }
				else { error (element, "cannot apply this operation on binary variable"); }
			}

			else { error (element, "unknown TYPE"); }
		}

		else { error (element, "unknown element"); }
	}

	if (printedText) { while (std::cin.get() != '\n'); }
}


void error (const TiXmlElement *element, string text)
{
	std::cerr << "Error at line " << (element->Row()) << " with " << element->ValueTStr().c_str() << ": " << text << std::endl;
}


bool testValue (const TiXmlElement *element, string value)
{
	if (element->ValueTStr().c_str() != value)
	{
		error (element, "should be " + value);
		return false;
	}
	return true;
}


bool testAttribute (const TiXmlElement *element, string attribute)
{
	if (element->Attribute(attribute.c_str()) == NULL)
	{
		error (element, "attribute " + attribute + " is missing");
		return false;
	}
	return true;
}


bool testChild (const TiXmlElement *element, string child)
{
	const TiXmlNode *c = element->FirstChild(child.c_str());
	if (c == NULL)
	{
		error (element, "should have child " + child);
		return false;
	}
	return true;
}


