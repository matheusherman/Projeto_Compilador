grammar Parser;

// Importa o lexer
import Lexer;
options { tokenVocab=Lexer; }


program: (statement
       | function)*
       ;

statement: hardware_statement
         | function_call
         | variable_declaration
         | comparison_expression
         | assignment
         | while_statement
         | for_statement
         | if_statement
         | return_statement
         ;

hardware_statement: PIN '(' params ')' SEMICOLON
                  | WRITE '(' params ')' SEMICOLON
                  | DELAY '(' params ')' SEMICOLON
                  | READ '(' params ')' SEMICOLON
                  ;
 
variable_declaration: ID ':' type SEMICOLON
                    | ID ':' type (ASSIGN expression)? SEMICOLON
					| ID ':' type (ASSIGN expression)? 
				 	| assignment
					;

type: INT | FLOAT16 | BOOL | VOID;

expression: comparison_expression
          | primary_expression
          | arithmetic_expression
          | NOT expression
          ;

arithmetic_expression: primary_expression ((MULTI | DIV | PLUS | MINUS) primary_expression)*;

primary_expression: ID
                 | NUM_INT
                 | NUM_FLOAT
                 | TRUE
                 | FALSE
                 | function_call
                 | '(' expression ')'
                 ;
                 
function_call: ID '(' (expression (COMMA expression)*)? ')' SEMICOLON
            | ID '(' (expression (COMMA expression)*)? ')';

function: DEF ID '(' params ')' ARROW type ':' block;

params: (param (COMMA param)*)?;

param: ID ':' type | ID;

block: LBRACE statement* RBRACE;

while_statement: WHILE '(' expression ')' ':' block;

if_statement: IF '(' expression ')' ':' block (ELSE ':' block)? 
            | IF '(' expression ')' ':';

initialization: variable_declaration 
                | expression
                ;

for_statement: FOR '(' initialization ';' expression ';' assignment ')'':' block;

return_statement: RETURN expression SEMICOLON;

comparison_expression: ID comparison_operator expression;

comparison_operator: EQUAL
                 | NOT_EQUAL
                 | LESS_THAN
                 | GREATER_THAN
                 | LESS_THAN_OR_EQUAL
                 | GREATER_THAN_OR_EQUAL
                 ;

assignment: ID ASSIGN expression SEMICOLON 
          | ID ASSIGN hardware_statement
		  | ID ASSIGN expression
 		  ;
