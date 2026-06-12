module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done
);

    parameter BYTE1 = 2'd0;
    parameter BYTE2 = 2'd1;
    parameter BYTE3 = 2'd2;
    parameter DONE  = 2'd3;

    reg [1:0] state, next_state;

    // Combinational Next-State Logic
    always @(*) begin
        case (state)
            BYTE1: next_state = (in[3]) ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = (in[3]) ? BYTE2 : BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // Sequential State Register
    always @(posedge clk) begin
        if (reset) state <= BYTE1;
        else       state <= next_state;
    end

    // Moore Output Logic
    assign done = (state == DONE);

endmodule
