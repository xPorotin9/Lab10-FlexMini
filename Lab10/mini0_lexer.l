%{
#include "mini0_token.h"
#include <vector>
#include <cstdlib>
#include <sstream>

// Vector global para almacenar todos los tokens
vector<Token> tokens;

// Función para procesar strings con escapes
string processString(const char* str);

// Función para convertir hexadecimal a decimal
int hexToInt(const char* str);

%}

/* Opciones de Flex */
%option noyywrap
%option yylineno

/* Definiciones regulares */
DIGIT       [0-9]
LETTER      [a-zA-Z]
HEX_DIGIT   [0-9a-fA-F]

/* Números */
DECIMAL     {DIGIT}+
HEXADECIMAL 0x{HEX_DIGIT}+

/* Identificadores */
ID          ({LETTER}|_)({LETTER}|{DIGIT}|_)*

/* Espacios y saltos */
WHITESPACE  [ \t\r]+
NEWLINE     \n

/* Estados para comentarios */
%x COMMENT_BLOCK

%%

    /* ========== COMENTARIOS ========== */
    
"/*"                    { BEGIN(COMMENT_BLOCK); }
<COMMENT_BLOCK>"*/"     { BEGIN(INITIAL); }
<COMMENT_BLOCK>.        { /* Ignorar contenido */ }
<COMMENT_BLOCK>\n       { /* Mantener cuenta de líneas */ }

"//".*                  { /* Comentario de línea - ignorar */ }

    /* ========== PALABRAS RESERVADAS ========== */
    
"if"        { tokens.push_back(Token(TOK_IF, yytext, yylineno)); }
"else"      { tokens.push_back(Token(TOK_ELSE, yytext, yylineno)); }
"end"       { tokens.push_back(Token(TOK_END, yytext, yylineno)); }
"while"     { tokens.push_back(Token(TOK_WHILE, yytext, yylineno)); }
"loop"      { tokens.push_back(Token(TOK_LOOP, yytext, yylineno)); }
"fun"       { tokens.push_back(Token(TOK_FUN, yytext, yylineno)); }
"return"    { tokens.push_back(Token(TOK_RETURN, yytext, yylineno)); }
"new"       { tokens.push_back(Token(TOK_NEW, yytext, yylineno)); }
"string"    { tokens.push_back(Token(TOK_STRING_TYPE, yytext, yylineno)); }
"int"       { tokens.push_back(Token(TOK_INT, yytext, yylineno)); }
"char"      { tokens.push_back(Token(TOK_CHAR, yytext, yylineno)); }
"bool"      { tokens.push_back(Token(TOK_BOOL, yytext, yylineno)); }
"true"      { tokens.push_back(Token(TOK_TRUE, yytext, yylineno)); }
"false"     { tokens.push_back(Token(TOK_FALSE, yytext, yylineno)); }
"and"       { tokens.push_back(Token(TOK_AND, yytext, yylineno)); }
"or"        { tokens.push_back(Token(TOK_OR, yytext, yylineno)); }
"not"       { tokens.push_back(Token(TOK_NOT, yytext, yylineno)); }

    /* ========== OPERADORES DE DOS CARACTERES ========== */
    
">="        { tokens.push_back(Token(TOK_GTE, yytext, yylineno)); }
"<="        { tokens.push_back(Token(TOK_LTE, yytext, yylineno)); }
"<>"        { tokens.push_back(Token(TOK_NEQ, yytext, yylineno)); }

    /* ========== OPERADORES Y PUNTUACIÓN ========== */
    
"("         { tokens.push_back(Token(TOK_LPAREN, yytext, yylineno)); }
")"         { tokens.push_back(Token(TOK_RPAREN, yytext, yylineno)); }
"["         { tokens.push_back(Token(TOK_LBRACKET, yytext, yylineno)); }
"]"         { tokens.push_back(Token(TOK_RBRACKET, yytext, yylineno)); }
","         { tokens.push_back(Token(TOK_COMMA, yytext, yylineno)); }
":"         { tokens.push_back(Token(TOK_COLON, yytext, yylineno)); }
"+"         { tokens.push_back(Token(TOK_PLUS, yytext, yylineno)); }
"-"         { tokens.push_back(Token(TOK_MINUS, yytext, yylineno)); }
"*"         { tokens.push_back(Token(TOK_MULT, yytext, yylineno)); }
"/"         { tokens.push_back(Token(TOK_DIV, yytext, yylineno)); }
">"         { tokens.push_back(Token(TOK_GT, yytext, yylineno)); }
"<"         { tokens.push_back(Token(TOK_LT, yytext, yylineno)); }
"="         { tokens.push_back(Token(TOK_EQ, yytext, yylineno)); }

    /* ========== LITERALES ========== */
    
{DECIMAL}   { 
    int value = atoi(yytext);
    tokens.push_back(Token(TOK_NUMBER, yytext, value, yylineno)); 
}

{HEXADECIMAL} { 
    int value = hexToInt(yytext);
    tokens.push_back(Token(TOK_NUMBER, yytext, value, yylineno)); 
}

\"([^\"\\\n]|\\.)*\" {
    string processed = processString(yytext);
    tokens.push_back(Token(TOK_STRING, yytext, processed, yylineno));
}

    /* ========== IDENTIFICADORES ========== */
    
{ID}        { tokens.push_back(Token(TOK_ID, yytext, yylineno)); }

    /* ========== SALTOS DE LÍNEA ========== */
    
{NEWLINE}+  { tokens.push_back(Token(TOK_NL, "\\n", yylineno)); }

    /* ========== ESPACIOS EN BLANCO ========== */
    
{WHITESPACE} { /* Ignorar espacios */ }

    /* ========== CARACTERES NO RECONOCIDOS ========== */
    
.           { tokens.push_back(Token(TOK_ERROR, yytext, yylineno)); }

%%

/* ========== FUNCIONES AUXILIARES ========== */

string processString(const char* str) {
    string result;
    // Saltar las comillas iniciales y finales
    for (int i = 1; str[i+1] != '\0'; i++) {
        if (str[i] == '\\' && str[i+1] != '\0') {
            switch(str[i+1]) {
                case 'n': result += '\n'; i++; break;
                case 't': result += '\t'; i++; break;
                case '\\': result += '\\'; i++; break;
                case '"': result += '"'; i++; break;
                default: result += str[i]; break;
            }
        } else {
            result += str[i];
        }
    }
    return result;
}

int hexToInt(const char* str) {
    int value = 0;
    sscanf(str, "%x", &value);
    return value;
}

/* ========== FUNCIÓN PRINCIPAL ========== */

int main(int argc, char* argv[]) {
    if (argc != 2) {
        cerr << "Uso: " << argv[0] << " <archivo.mini0>" << endl;
        return 1;
    }
    
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        cerr << "Error: No se pudo abrir el archivo " << argv[1] << endl;
        return 1;
    }
    
    cout << "=== ANÁLISIS LÉXICO DE " << argv[1] << " ===" << endl;
    cout << endl;
    
    // Ejecutar el análisis léxico
    yylex();
    
    // Agregar token EOF
    tokens.push_back(Token(TOK_EOF, "EOF", yylineno));
    
    // Imprimir todos los tokens
    cout << "TOKENS ENCONTRADOS:" << endl;
    cout << "===================" << endl;
    for (const Token& tok : tokens) {
        printToken(tok);
    }
    
    // Estadísticas
    cout << endl;
    cout << "=== ESTADÍSTICAS ===" << endl;
    cout << "Total de tokens: " << tokens.size() << endl;
    
    int errors = 0;
    for (const Token& tok : tokens) {
        if (tok.type == TOK_ERROR) errors++;
    }
    
    if (errors > 0) {
        cout << "Errores léxicos encontrados: " << errors << endl;
    } else {
        cout << "No se encontraron errores léxicos." << endl;
    }
    
    fclose(yyin);
    return 0;
}