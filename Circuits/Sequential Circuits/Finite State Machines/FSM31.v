module top_module (
    input [5:0] y,
    input w,
    output Y1,
    output Y3
);

    // Y1 is State B. Entered only from State A (y[0]) when w=1.
    assign Y1 = y[0] & w;
    
    // Y3 is State D. Entered from States B(y[1]), C(y[2]), E(y[4]), F(y[5]) when w=0.
    assign Y3 = (y[1] | y[2] | y[4] | y[5]) & ~w;

endmodule
