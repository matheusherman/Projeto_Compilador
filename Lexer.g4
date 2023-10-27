lexer grammar Lexer;

// geral
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

// hardware 
PIN: 'pin';
WRITE: 'write';
DELAY: 'delay';
READ: 'read';

// boleans
TRUE: 'true';
FALSE: 'false';

// operadores
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
COLLON: ':';

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