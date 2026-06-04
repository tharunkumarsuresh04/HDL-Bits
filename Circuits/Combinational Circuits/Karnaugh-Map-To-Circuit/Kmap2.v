/**/

module top_module(
    input a,
    input b,
    input c,
    input d,
    output out  ); 
    
    wire out_pseudo;
    assign out_pseudo = (a & c & d) | (b & c & d) ;
    assign out = (~b & ~c) | (~a & ~d) | out_pseudo;

endmodule
