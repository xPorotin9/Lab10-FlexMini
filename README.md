# Lab10-FlexMini

# 1. Generar el código C desde Flex
.\win_flex.exe mini0_lexer.l

# 2. Compilar el archivo de token
g++ -c mini0_token.cpp -o mini0_token.o

# 3. Compilar el archivo generado por Flex
g++ -c lex.yy.c -o lex.yy.o

# 4. Enlazar todo y crear el ejecutable
g++ mini0_token.o lex.yy.o -o mini0_lexer.exe

# 5. Ejecutar
.\mini0_lexer.exe test.mini0
