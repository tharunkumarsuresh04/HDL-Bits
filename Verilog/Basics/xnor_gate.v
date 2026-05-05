/*
Create a module that implements an XNOR gate.

Expected solution length: Around 1 line.
*/

module top_module( 
    input a, 
    input b, 
    output out );
	
    assign out = a ~^ b;
endmodule
