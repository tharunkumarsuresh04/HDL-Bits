/*
Build a combinational circuit with four inputs, in[3:0].

There are 3 outputs:

out_and: output of a 4-input AND gate.
out_or: output of a 4-input OR gate.
out_xor: output of a 4-input XOR gate.
To review the AND, OR, and XOR operators, see andgate, norgate, and xnorgate.

See also: Even wider gates
*/

module top_module( 
    input [3:0] in,
    output out_and,
    output out_or,
    output out_xor

);
    wire w1, w2;
    and a1 (out_and, in[0], in[1], in[2], in[3]);
    or o1 (out_or, in[0], in[1], in[2], in[3]);
    xor x1 (w1, in[0], in[1]);
    xor x2 (w2, in[2], in[3]);
    xor x3 (out_xor, w1, w2);
    
endmodule
