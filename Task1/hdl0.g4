grammar hdl0;

start : (
hardware+
inputs+ |
outputs+ |
latches+
)+ EOF;

// Define the hardware rule
hardware: '.hardware' CIRCUITNAME;

// Define the inputs rule
inputs: '.inputs' BIT (BIT+);

// Define the outputs rule
outputs: '.outputs' BIT (BIT+);

// Define the latches rule
latches: '.latches' ('!'){1} BIT (BIT+);

// Define an identifier rule
CIRCUITNAME: [A-Za-z_][A-Za-z0-9_]*;

// Bit
BIT: [0] | [1];

// Define whitespace rule (skip whitespace)
WS: [ \t\r\n]+ -> skip;