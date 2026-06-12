module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output [7:0] out_byte,
    output done
); //
    parameter IDLE = 0, D0 = 1, D1 = 2, D2 = 3, D3 = 4, D4 = 5, D5 = 6, D6 = 7, D7 = 8, PARITY = 9, STOP = 10, ERROR_WAIT = 11, DONE = 12;
    
    reg [3:0] present_state, next_state;
    reg [7:0] shift_reg;
    
    wire odd;
    wire parity_reset;
    
    
    always @(*) begin
        
        case (present_state)
            
            IDLE: begin
                next_state = (~in) ? D0 : IDLE;
            end
            
            D0: begin
                next_state = D1; 
            end
            
            D1: begin
                next_state = D2; 
            end
            
            D2: begin
                next_state = D3;
            end
            
            D3: begin
                next_state = D4;
            end
            
            D4: begin
                next_state = D5; 
            end
            
            D5: begin
                next_state = D6;
            end
            
            D6: begin
                next_state = D7;
            end
            
            D7: begin
                next_state = PARITY;
            end
            
            PARITY: begin
                next_state = STOP;
            end
            
            STOP: begin
                if(~in) begin
                    next_state = ERROR_WAIT;
                end
                else if (odd) begin
                    next_state = DONE;
                end
                else begin
                    next_state = IDLE;
                end
            end
            ERROR_WAIT: begin
                next_state = (in) ? IDLE : ERROR_WAIT;
            end
            DONE: begin
                next_state = (~in) ? D0 : IDLE;
            end
            default: begin
                next_state = IDLE;
            end
            
        endcase
    end
    
    always @(posedge clk) begin
        if(reset) begin
            present_state <= IDLE;
        end
        
        else begin
            present_state <= next_state;
        end
    end
    
    always @(posedge clk) begin
        if (present_state >= D0 && present_state <= D7) begin
            shift_reg <= { in , shift_reg[7:1] };
        end
    end
    
    assign parity_reset = reset | (present_state == DONE) | (present_state == ERROR_WAIT) | (present_state == IDLE);
    
    parity inst1( .clk(clk),
                  .reset(parity_reset),
                  .in(in),
                  .odd(odd)
                );
    
    assign done = (present_state == DONE); 
    assign out_byte = shift_reg;


endmodule
