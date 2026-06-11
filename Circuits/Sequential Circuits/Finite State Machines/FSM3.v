module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=0, ON=1; 
    reg state, next_state;

    always @(*) begin
        case (state)
            OFF: begin
                next_state = (j == 1'b1) ? ON : OFF;
            end
            ON: begin
                next_state = (k == 1'b1) ? OFF : ON;
            end
            default: begin
                next_state = OFF;
            end
        endcase
        // State transition logic
    end

    always @(posedge clk, posedge areset) begin
        if(areset) begin
            state <= OFF;
        end
        else begin
            state <= next_state;
        end
                // State flip-flops with asynchronous reset
    end
	
    assign out = (state == ON);
    // Output logic
    // assign out = (state == ...);

endmodule
