grammar hdl1;

start : (
hardware+|
inputs+ |
outputs+ |
update+ |
initialization+ |
declaration+ |
simulate+ |
latches+
)+ EOF;
//TODO add Variable declaration
//TODO add .simulate
declaration: DECLARATION initialization?;

// Define the hardware rule
hardware: '.hardware ' DECLARATION;

// Define the inputs rule
inputs: '.inputs' (' ' IDENTIFIER)+;

// Define the outputs rule
outputs: '.outputs' (' ' IDENTIFIER)+;

// Define the latches rule
latches: '.latches' (WS? latch)+;

update: '.update' (expression+ ' '*? '=' ' '*? expression*)+;

initialization : '=' BIT+;
// smarter way to fix white space for simulate
simulate: '.simulate'  IDENTIFIER '=' BINARY+
| '.simulate ' IDENTIFIER '=' BINARY+;

latch : IDENTIFIER ' -> ' IDENTIFIER;


expression : IDENTIFIER
            | '(' ' '*? expression ' '*? ')'
            | '!' expression
            | expression ' '*? '&&' ' '*? expression
            | expression ' '*? '||' ' '*?  expression
            ;

// variable decleration
DECLARATION: [a-z]+;
IDENTIFIER : [A-Z] [a-zA-Z_0-9]* ;  // X
//INITILIZATION: '=' BIT*;
// Bit

BOP : ('&&' | '||' | '!') ;        // &&, ||
BINARY : [01]+ ;


COMMENT : '//' ~[\n]* -> skip;
LONGCOMMENT : '/*' (~[*] | '*'~[/])* '*/' -> skip;
WS: [ \t\r\n'']+ -> skip;