#ifndef MINI0_TOKEN_H
#define MINI0_TOKEN_H

#include <string>
#include <iostream>

using namespace std;

// Tipos de tokens
enum TokenType {
    // Literales
    TOK_NUMBER,
    TOK_STRING,
    TOK_TRUE,
    TOK_FALSE,
    
    // Palabras reservadas
    TOK_IF,
    TOK_ELSE,
    TOK_END,
    TOK_WHILE,
    TOK_LOOP,
    TOK_FUN,
    TOK_RETURN,
    TOK_NEW,
    TOK_STRING_TYPE,
    TOK_INT,
    TOK_CHAR,
    TOK_BOOL,
    TOK_AND,
    TOK_OR,
    TOK_NOT,
    
    // Identificadores
    TOK_ID,
    
    // Operadores y puntuación
    TOK_LPAREN,     // (
    TOK_RPAREN,     // )
    TOK_LBRACKET,   // [
    TOK_RBRACKET,   // ]
    TOK_COMMA,      // ,
    TOK_COLON,      // :
    TOK_PLUS,       // +
    TOK_MINUS,      // -
    TOK_MULT,       // *
    TOK_DIV,        // /
    TOK_GT,         // >
    TOK_LT,         // <
    TOK_GTE,        // >=
    TOK_LTE,        // <=
    TOK_EQ,         // =
    TOK_NEQ,        // <>
    
    // Especiales
    TOK_NL,         // Salto de línea
    TOK_EOF,        // Fin de archivo
    TOK_ERROR       // Token de error
};

// Estructura para representar un token
struct Token {
    TokenType type;
    string lexeme;      // Texto original del token
    string stringValue; // Valor string (para strings procesados)
    int intValue;       // Valor entero (para números)
    int line;           // Línea donde aparece
    
    Token(TokenType t, const string& lex, int ln) 
        : type(t), lexeme(lex), line(ln), intValue(0) {}
    
    Token(TokenType t, const string& lex, int val, int ln) 
        : type(t), lexeme(lex), intValue(val), line(ln) {}
    
    Token(TokenType t, const string& lex, const string& str, int ln) 
        : type(t), lexeme(lex), stringValue(str), line(ln), intValue(0) {}
};

// Función para obtener el nombre del tipo de token
string getTokenTypeName(TokenType type);

// Función para imprimir un token
void printToken(const Token& token);

#endif