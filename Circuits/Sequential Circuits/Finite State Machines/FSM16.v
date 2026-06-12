module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done
);

    parameter BYTE1 = 2'd0, BYTE2 = 2'd1, BYTE3 = 2'd2, DONE = 2'd3;
    reg [1:0] state, next_state;

    // Control Path: Next State Logic
    always @(*) begin
        case (state)
            BYTE1: next_state = (in[3]) ? BYTE2 : BYTE1;
            BYTE2: next_state = BYTE3;
            BYTE3: next_state = DONE;
            DONE:  next_state = (in[3]) ? BYTE2 : BYTE1;
            default: next_state = BYTE1;
        endcase
    end

    // Control Path: State Register
    always @(posedge clk) begin
        if (reset) state <= BYTE1;
        else       state <= next_state;
    end

    // Datapath: 24-bit Assembly Register
    reg [23:0] data_reg;
    always @(posedge clk) begin
        // Capture Byte 1 (from Search or back-to-back contiguous states)
        if ((state == BYTE1 && in[3]) || (state == DONE && in[3])) begin
            data_reg[23:16] <= in;
        end
        // Capture Byte 2
        else if (state == BYTE2) begin
            data_reg[15:8] <= in;
        end
        // Capture Byte 3
        else if (state == BYTE3) begin
            data_reg[7:0] <= in;
        end
    end

    assign done = (state == DONE);
    assign out_bytes = data_reg;

endmodule
