module top_module (
    input clk,
    input reset,   // Synchronous reset
    input x,
    output z
);
    reg [2:0] present_state, next_state;
    
    
    always @(*) begin
        
        case(present_state)
            
            3'b000: begin
                
                next_state = (x) ? 3'b001 : 3'b000;
                
            end
            
            3'b001: begin
                
                next_state = (x) ? 3'b100 : 3'b001;

            end
            
            3'b010: begin
                
                next_state = (x) ? 3'b001 : 3'b010;
            
            end
            
            3'b011: begin
                
                next_state = (x) ? 3'b010 : 3'b001;
                
            end
            
            3'b100: begin
                
                next_state = (x) ? 3'b100 : 3'b011;
                
            end
            
            default: begin
                
                next_state = 3'b000;
                
            end
            
        endcase
        
    end

    
    always @(posedge clk) begin
        
        if(reset) begin
            
            present_state <= 3'b000;
            
        end
        
        else begin
            
            present_state <= next_state;
            
        end
        
    end
        
    
    assign z = (present_state == 3'b011) | (present_state == 3'b100);

endmodule
