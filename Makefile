CC=g++
CFLAGS=-pg -g -c -Wall
LDFLAGS=-pg
SOURCESA=tinyxml.cpp tinyxmlparser.cpp tinyxmlerror.cpp tinystr.cpp
OBJECTSA=$(SOURCESA:.cpp=.o)
SOURCESB=story_reader.cpp
OBJECTSB=$(SOURCESB:.cpp=.o)
EXECUTABLE=$(SOURCESB:.cpp=)

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTSA:%=src/%) $(OBJECTSB:%=src/%)
	$(CC) $(LDFLAGS) $(OBJECTSA:%=src/%) src/$@.o -o bin/$@

src/%.o: src/%.cpp
	$(CC) $(CFLAGS) src/$*.cpp -o $@

clean:
	rm -f $(OBJECTSA:%=src/%) $(OBJECTSB:%=src/%) $(EXECUTABLE:%=bin/%)
