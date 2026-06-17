module top_module (
    input clk,
    input reset,      // Synchronous reset
    output shift_ena
);

    parameter IDLE=3'd0, S1=3'd1, S2=3'd2, S3=3'd3, S4=3'd4;
    reg [2:0] state, next_state;

    // Combinational Next-State Sequence
    always @(*) begin
        case (state)
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = IDLE;
            IDLE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Sequential State Update
    always @(posedge clk) begin
        if (reset) begin
            state <= S1;
        end else begin
            state <= next_state;
        end
    end

    // Moore Output Decoder
    assign shift_ena = (state != IDLE);

endmodule
