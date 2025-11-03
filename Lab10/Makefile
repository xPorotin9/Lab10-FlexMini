# Compilador y flags
CXX = g++
CXXFLAGS = -Wall -std=c++11
LEX = flex

# Archivos
SOURCES = mini0_token.cpp lex.yy.c
OBJECTS = mini0_token.o lex.yy.o
TARGET = mini0_lexer

# Regla principal
all: $(TARGET)

# Generar código de Flex
lex.yy.c: mini0_lexer.l
	$(LEX) mini0_lexer.l

# Compilar ejecutable
$(TARGET): $(OBJECTS)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJECTS)

# Compilar objetos
mini0_token.o: mini0_token.cpp mini0_token.h
	$(CXX) $(CXXFLAGS) -c mini0_token.cpp

lex.yy.o: lex.yy.c mini0_token.h
	$(CXX) $(CXXFLAGS) -c lex.yy.c

# Limpiar
clean:
	rm -f $(OBJECTS) lex.yy.c $(TARGET)

# Ejecutar prueba
test: $(TARGET)
	./$(TARGET) test.mini0

.PHONY: all clean test