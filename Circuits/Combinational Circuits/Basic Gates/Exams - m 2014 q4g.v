/*
Implement the following circuit:
    
        Y = ( (A XNOR B) Ex-OR C)

*/

module top_module (
    input in1,
    input in2,
    input in3,
    output out);
	
    wire w1;
    xnor xn1 (w1, in1, in2);
    xor x1(out, w1, in3);
    
endmodule

