grammar hdl0;

start : (
hardware+
inputs+ |
outputs+ |
update+ |
latches+
)+ EOF;
//TODO add Variable declaration
//TODO add .simulate
// Define the hardware rule
hardware: '.hardware' DECLERATION;

// Define the inputs rule
inputs: '.inputs' BIT (BIT+);

// Define the outputs rule
outputs: '.outputs' BIT (BIT+);

// Define the latches rule
latches: '.latches' ('!'){1} BIT (BIT+);

update: '.update' x=DECLERATION '=' NOT? DECLERATION BOP NOT? DECLERATION
        | b = BIT
        | signal=update BOP exp=update;

// variable decleration
DECLERATION: [A-Za-z_][A-Za-z0-9_]*;
// Bit
BIT: [0] | [1];
NOT: '!';
BOP : (AND | OR | NOT) ;        // &&, ||
AND: '&&';
OR: '||';
IDENTIFIER : [a-zA-Z] [a-zA-Z_0-9]* ;  // x17y
FLOAT      : [0-9]+ ('.' [0-9]+)? ;     // 17.42

// Define whitespace rule (skip whitespace)
WS: [ \t\r\n]+ -> skip;