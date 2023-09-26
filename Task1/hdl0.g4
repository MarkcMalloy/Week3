grammar hdl0;

start : (
hardware+
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

initialization : '=' BIT+;
// Define the hardware rule
hardware: '.hardware ' DECLARATION;

// Define the inputs rule
inputs: '.inputs' (' ' IDENTIFIER)+;

// Define the outputs rule
outputs: '.outputs' (' ' IDENTIFIER)+;

// Define the latches rule
latches: '.latches' (' '? latch)+;

update: '.update' (expression ' = ' expression)+;

simulate: '.simulate'  IDENTIFIER '=' BINARY+;



latch : IDENTIFIER ' -> ' IDENTIFIER;

expression : IDENTIFIER
            | '(' expression ')'
            | '!' expression
            | expression ' && ' expression
            | expression '||' expression
            ;

// variable decleration
DECLARATION: [a-z]+;
IDENTIFIER : [A-Z] [a-zA-Z_0-9]* ;  // x17y
//INITILIZATION: '=' BIT*;
// Bit

BOP : ('&&' | '||' | '!') ;        // &&, ||
BINARY : [01]+ ;


// Define whitespace rule (skip whitespace)
WS: [ \t\r\n]+ -> skip;