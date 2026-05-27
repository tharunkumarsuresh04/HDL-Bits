/*
You are provided with a BCD (binary-coded decimal) one-digit adder named bcd_fadd that adds two BCD digits and carry-in, and produces a sum and carry-out.

module bcd_fadd (
    input [3:0] a,
    input [3:0] b,
    input     cin,
    output   cout,
    output [3:0] sum );
Instantiate 4 copies of bcd_fadd to create a 4-digit BCD ripple-carry adder. 
Your adder should add two 4-digit BCD numbers (packed into 16-bit vectors) and a carry-in to produce a 4-digit sum and carry out.
*/

module top_module ( 
    input [15:0] a, b,
    input cin,
    output cout,
    output [15:0] sum 
);
    wire c1, c2, c3;

    bcd_fadd inst1 ( .a(a[3:0]), .b(b[3:0]), .cin(cin), .sum(sum[3:0]), .cout(c1) );

    bcd_fadd inst2 ( .a(a[7:4]), .b(b[7:4]), .cin(c1), .sum(sum[7:4]), .cout(c2)   );
    
    bcd_fadd inst3 ( .a(a[11:8]), .b(b[11:8]), .cin(c2), .sum(sum[11:8]), .cout(c3) );

    bcd_fadd inst4 ( .a(a[15:12]), .b(b[15:12]), .cin(c3), .sum(sum[15:12]), .cout(cout) );

endmodule
