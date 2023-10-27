# Fase 2 - Verificação de Código – Análise Sintática e Semântica

# Alunos
**`ERICK LEMMY DOS SANTOS OLIVEIRA`**<br>
**`GABRIELLE BATISTA GARCIA`**<br>
**`LEANDRO RICARDO GUIMARÃES`**<br>
**`MATHEUS HERMAN BERNARDIM ANDRADE`**<br>

# Link para rodar o analisador léxico
https://replit.com/@matheusherman/Compiladores#Fase_2 <br>
**`PARA RODAR É NECESSÁRIO DIGITAR O COMANDO ABAIXO`**<br>
**`python3 parser.py testeX.cpy`**<br>
**`OS ARQUIVOS DISPONÍVEIS SÃO TESTE.CPY, TESTE1.CPY, TESTE2.CPY TESTE3.CPY E TESTE4.CPY`**<br>

## Descrição da Fase

Nesta fase você deverá implementar um analisador sintático usando um parser, usando LL1, ou LR1
e uma estrutura baseada em cálculo de sequentes para a verificação dos tipos dos identificadores,
valores e expressões criadas na sua linguagem. Alternativamente, você pode usar o Antlr para gerar
o analisador sintático. Observe que, caso use o Antlr, a parte referente a análise semântica, deverá
ser implementada de forma a complementar o código gerado pelo Antlr.


## Análise Léxica
O analisador léxico transforma o código-fonte em uma sequência de tokens, como palavras-chave, identificadores, números e símbolos. Ele reconhece tipos de dados, estruturas de controle, operadores e outros elementos da linguagem .Cpy.
```
lexer grammar Lexer;

// Geral
INT: 'int';
FLOAT16: 'float16';
BOOL: 'bool';
VOID: 'void';

DEF: 'def';
FOR: 'for';
WHILE: 'while';
IF: 'if';
ELIF: 'elif';
ELSE: 'else';
RETURN: 'return';
ID: [a-zA-Z_][a-zA-Z0-9_]*;
NUM_INT: [0-9]+;
NUM_FLOAT: [0-9]+'.'[0-9]+;
WS: [ \t\n\r]+ -> skip; // Ignorar espaços em branco
COMMENT: '//' ~[\r\n]* -> skip;

// Hardware 
PIN: 'pin';
WRITE: 'write';
DELAY: 'delay';
READ: 'read';

// Booleans
TRUE: 'true';
FALSE: 'false';

// Operadores
PLUS: '+';
MINUS: '-';
MULTI: '*';
DIV: '/';
ASSIGN: '=';
SEMICOLON: ';';
LPAREN: '(';
RPAREN: ')';
COMMA: ',';
LBRACE: '{';
RBRACE: '}';
ARROW: '->';
COLON: ':';

// Tokens para operadores de comparação
EQUAL: '==';
NOT_EQUAL: '!=';
LESS_THAN: '<';
GREATER_THAN: '>';
LESS_THAN_OR_EQUAL: '<=';
GREATER_THAN_OR_EQUAL: '>=';

// Tokens para lógica
NOT: '!';
OR: '||';
AND: '&&';
```

## Análise Sintática
O analisador sintático, baseado no ANTLR, verifica a estrutura gramatical do código. Ele interpreta declarações de hardware, chamadas de funções, operações aritméticas e estruturas de controle de fluxo. Além disso, lida com aninhamentos e serve como base para análises semânticas.

```
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
```

## Análise Semântica
A análise semântica verifica o significado e o contexto do código-fonte, garantindo o uso correto de tipos, variáveis e funções. Isso é essencial para evitar erros e garantir a conformidade com as regras da linguagem.

## Testes e Validação
Foram realizados testes em códigos .Cpy para verificar a correta detecção de erros e o funcionamento do compilador.


