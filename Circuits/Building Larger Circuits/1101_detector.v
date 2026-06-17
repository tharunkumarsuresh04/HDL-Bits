module top_module (
    input clk,
    input reset,      // Synchronous reset
    input data,
    output start_shifting);
    
    parameter S0 = 3'b000, S1 = 3'b001, S11 = 3'b010, S110 = 3'b011, DONE = 3'b100;
    
    reg [2:0] present_state, next_state;
     
    always @(*) begin
        
        case (present_state)
            
            S0: begin
                next_state = (data) ? S1 : S0;
            end
            
            S1: begin
                next_state = (data) ? S11 : S0;
            end
            
            S11: begin
                next_state = (data) ? S11 : S110;
            end
            
            S110: begin
                next_state = (data) ? DONE : S0;
            end
            
            DONE: begin
                next_state = DONE;
            end
            
            default: begin
                next_state = S0;
            end
            
        endcase
        
    end
       
    always @(posedge clk) begin
        
        if(reset) begin
            present_state <= S0;
        end
        
        else begin
            present_state <= next_state;
        end
    end
    
    assign start_shifting = (present_state == DONE);
    

endmodule
