    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
);

    // 12 distinct states perfectly aligned to the UART baud protocol
    parameter IDLE=0, D0=1, D1=2, D2=3, D3=4, D4=5, D5=6, D6=7, D7=8;
    parameter STOP=9, ERROR_WAIT=10, DONE=11;

    reg [3:0] state, next_state;

    // Combinational Next-State Logic
    always @(*) begin
        case (state)
            IDLE: next_state = (~in) ? D0 : IDLE; // Jump directly to D0 to prevent 1-cycle slip
            D0: next_state = D1;
            D1: next_state = D2;
            D2: next_state = D3;
            D3: next_state = D4;
            D4: next_state = D5;
            D5: next_state = D6;
            D6: next_state = D7;
            D7: next_state = STOP;
            STOP: next_state = (in) ? DONE : ERROR_WAIT; // Verify stop bit here
            ERROR_WAIT: next_state = (in) ? IDLE : ERROR_WAIT;
            DONE: next_state = (~in) ? D0 : IDLE; // Handle back-to-back packets cleanly
            default: next_state = IDLE;
        endcase
    end

    // Sequential State Register
    always @(posedge clk) begin
        if (reset) state <= IDLE;
        else       state <= next_state;
    end

    assign done = (state == DONE);

endmodule
