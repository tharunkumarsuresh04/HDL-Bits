/*
Implement the following Circuit: 
4 Full Adders cascaded together Serially, such a way that the last carry of the Full Adder block acts as the Sum for the Final Full Adder block.
*/

module top_module (
    input [3:0] x,
    input [3:0] y, 
    output [4:0] sum);
    
    wire c1, c2, c3;
    fa fa_inst1 ( .x(x[0]), .y(y[0]), .cin(1'b0), .sum(sum[0]), .cout(c1) );
    fa fa_inst2 ( .x(x[1]), .y(y[1]), .cin(c1), .sum(sum[1]), .cout(c2) );
    fa fa_inst3 ( .x(x[2]), .y(y[2]), .cin(c2), .sum(sum[2]), .cout(c3) );
    fa fa_inst4 ( .x(x[3]), .y(y[3]), .cin(c3), .sum(sum[3]), .cout(sum[4]) ); 
        
endmodule

module fa(input x, input y, input cin, output sum, output cout);
    assign {cout, sum} = x + y + cin;
    
endmodule
