module top_module(
    input in,
    input [3:0] state,
    output [3:0] next_state,
    output out); //

    parameter A=4'b0000, B=4'b0001, C=4'b0010, D=4'b0011;

    // State transition logic: Derive an equation for each state flip-flop.
    assign next_state[A] = (state[0] & ~in) | (state[2] & ~in);
    assign next_state[B] = (state[0] & in) | (state[1] & in) | (state[3] &  in);
    assign next_state[C] = (state[1] & ~in) | (state[3] & ~in);
    assign next_state[D] = (state[2] & in);

    // Output logic: 
    assign out = state[3];

endmodule
