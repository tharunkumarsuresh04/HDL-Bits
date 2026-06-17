module top_module (
    input clk,
    input aresetn,    // Asynchronous active-low reset
    input x,
    output z ); 
    
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
    
    reg [1:0] present_state, next_state;
        
    always @(*) begin
        
        case (present_state) 
            S0: begin
                next_state = (x) ? S1 : S0;
            end
            
            S1: begin
                next_state = (x) ? S1 : S2;
            end
            
            S2: begin
                next_state = (x) ? S1 : S0;
            end
            
            default: begin
                next_state = S0;
            end
            
        endcase 
    end
    
    always @(posedge clk or negedge aresetn) begin
        
        if (!aresetn) begin
            
            present_state <= S0;
            
        end
        
        else begin
            
            present_state <= next_state;
        end
        
    end
    
    assign z = (present_state == S2) && (x == 1);
    
endmodule
