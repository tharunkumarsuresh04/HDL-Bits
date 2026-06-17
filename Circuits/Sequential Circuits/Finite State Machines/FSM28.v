module top_module (
    input [6:1] y,
    input w,
    output Y2,
    output Y4
);

    // Y2: Entered only from State A (y[1]) when w=0
    assign Y2 = y[1] & ~w;
    
    // Y4: Entered from States B(y[2]), C(y[3]), E(y[5]), F(y[6]) when w=1
    assign Y4 = w & (y[2] | y[3] | y[5] | y[6]);

endmodule
