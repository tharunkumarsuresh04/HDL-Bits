module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
);

    parameter IDLE=0, D0=1, D1=2, D2=3, D3=4, D4=5, D5=6, D6=7, D7=8;
    parameter STOP=9, ERROR_WAIT=10, DONE=11;

    reg [3:0] state, next_state;

    // Control Path FSM
    always @(*) begin
        case (state)
            IDLE: next_state = (~in) ? D0 : IDLE;
            D0: next_state = D1; D1: next_state = D2;
            D2: next_state = D3; D3: next_state = D4;
            D4: next_state = D5; D5: next_state = D6;
            D6: next_state = D7; D7: next_state = STOP;
            STOP: next_state = (in) ? DONE : ERROR_WAIT;
            ERROR_WAIT: next_state = (in) ? IDLE : ERROR_WAIT;
            DONE: next_state = (~in) ? D0 : IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Sequential State Update
    always @(posedge clk) begin
        if (reset) state <= IDLE;
        else       state <= next_state;
    end

    // Datapath: Shift Register (LSB first alignment)
    reg [7:0] shift_reg;
    always @(posedge clk) begin
        // Capture data exclusively during active payload states
        if (state >= D0 && state <= D7) begin
            // Concatenate: new bit goes to MSB, everything else shifts right
            shift_reg <= {in, shift_reg[7:1]};
        end
    end

    assign done = (state == DONE);
    assign out_byte = shift_reg;

endmodule
