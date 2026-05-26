/*
Taken from 2015 midterm question 4

See mt2015_q4a and mt2015_q4b for the submodules used here. The top-level design consists of two instantiations each of subcircuits A and B, as shown

Implement that circuit.

*/

module top_module (input x, input y, output z);

    wire w1, w2, w3, w4, w5, w6;
    A inst_A1 (.x(x), .y(y), .z(w1));
    B inst_B1 (.x(x), .y(y), .z(w2));
    A inst_A2 (.x(x), .y(y), .z(w3));
    B inst_B2 (.x(x), .y(y), .z(w4));
    or or1 (w5, w1, w2);
    and and1 (w6, w3, w4);
    xor xor1 (z, w5, w6);
    
endmodule

module A (input x, input y, output z);
    assign z = (x ^ y) & x;
    
endmodule

module B (input x, input y, output z);
    assign z = ~(x ^ y);
    
endmodule
