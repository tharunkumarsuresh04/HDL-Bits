module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output [3:0] count,
    output counting,
    output done,
    input ack
);

    parameter S=0, S1=1, S11=2, S110=3, B0=4, B1=5, B2=6, B3=7, COUNT=8, WAIT=9;
    reg [3:0] state, next_state;
    reg [3:0] delay;
    reg [9:0] count_1k;

    // Control Path: FSM Next-State Logic
    always @(*) begin
        case(state)
            S:    next_state = data ? S1 : S;
            S1:   next_state = data ? S11 : S;
            S11:  next_state = data ? S11 : S110;
            S110: next_state = data ? B0 : S;
            B0:   next_state = B1;
            B1:   next_state = B2;
            B2:   next_state = B3;
            B3:   next_state = COUNT;
            // Transition out ONLY when the 1000-cycle timer expires AND delay is exhausted
            COUNT: next_state = (delay == 4'd0 && count_1k == 10'd999) ? WAIT : COUNT;
            WAIT:  next_state = ack ? S : WAIT;
            default: next_state = S;
        endcase
    end

    // Sequential Path: State and Datapath Registers
    always @(posedge clk) begin
        if (reset) begin
            state    <= S;
            delay    <= 4'd0;
            count_1k <= 10'd0;
        end else begin
            state <= next_state;
            
            // Shift Register Operation (MSB First)
            if (state == B0 || state == B1 || state == B2 || state == B3) begin
                delay <= {delay[2:0], data};
                count_1k <= 10'd0; // Prime the timer
            end
            // Timing ALU Operation
            else if (state == COUNT) begin
                if (count_1k == 10'd999) begin
                    count_1k <= 10'd0;
                    delay <= delay - 4'd1;
                end else begin
                    count_1k <= count_1k + 10'd1;
                end
            end
        end
    end

    // Output Mapping
    assign count    = delay;
    assign counting = (state == COUNT);
    assign done     = (state == WAIT);

endmodule
