#include "mini0_token.h"
#include <iomanip>

string getTokenTypeName(TokenType type) {
    switch(type) {
        case TOK_NUMBER: return "NUMBER";
        case TOK_STRING: return "STRING";
        case TOK_TRUE: return "TRUE";
        case TOK_FALSE: return "FALSE";
        case TOK_IF: return "IF";
        case TOK_ELSE: return "ELSE";
        case TOK_END: return "END";
        case TOK_WHILE: return "WHILE";
        case TOK_LOOP: return "LOOP";
        case TOK_FUN: return "FUN";
        case TOK_RETURN: return "RETURN";
        case TOK_NEW: return "NEW";
        case TOK_STRING_TYPE: return "STRING_TYPE";
        case TOK_INT: return "INT";
        case TOK_CHAR: return "CHAR";
        case TOK_BOOL: return "BOOL";
        case TOK_AND: return "AND";
        case TOK_OR: return "OR";
        case TOK_NOT: return "NOT";
        case TOK_ID: return "IDENTIFIER";
        case TOK_LPAREN: return "LPAREN";
        case TOK_RPAREN: return "RPAREN";
        case TOK_LBRACKET: return "LBRACKET";
        case TOK_RBRACKET: return "RBRACKET";
        case TOK_COMMA: return "COMMA";
        case TOK_COLON: return "COLON";
        case TOK_PLUS: return "PLUS";
        case TOK_MINUS: return "MINUS";
        case TOK_MULT: return "MULT";
        case TOK_DIV: return "DIV";
        case TOK_GT: return "GT";
        case TOK_LT: return "LT";
        case TOK_GTE: return "GTE";
        case TOK_LTE: return "LTE";
        case TOK_EQ: return "EQ";
        case TOK_NEQ: return "NEQ";
        case TOK_NL: return "NEWLINE";
        case TOK_EOF: return "EOF";
        case TOK_ERROR: return "ERROR";
        default: return "UNKNOWN";
    }
}

void printToken(const Token& token) {
    cout << "Línea " << setw(3) << token.line << ": ";
    cout << setw(15) << left << getTokenTypeName(token.type);
    cout << " | Lexema: " << setw(20) << left << token.lexeme;
    
    if (token.type == TOK_NUMBER) {
        cout << " | Valor: " << token.intValue;
    } else if (token.type == TOK_STRING) {
        cout << " | Valor: \"" << token.stringValue << "\"";
    }
    
    cout << endl;
}