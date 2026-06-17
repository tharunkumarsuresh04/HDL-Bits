module top_module (
    input clk,
    input reset,   // Synchronous reset
    input s,
    input w,
    output z
);
    
    parameter A = 3'b000, B0 = 3'b001, B1 = 3'b010, C0 = 3'b011, C1 = 3'b100, D0 = 3'b101, D1 = 3'b110, D2 = 3'b111;
    
    reg [2:0] present_state, next_state;
    
    always @(*) begin
        
        case (present_state)            
            A: begin
                
                next_state = (s) ? B0 : A;
                
            end
            
            B0: begin
                
                next_state = (w) ? C1 : C0;
                
            end
            
            B1: begin
                
                next_state = (w) ? C1 : C0;
                
            end
            
            C0: begin
                
                next_state = (w) ? D1 : D0;
                
                
            end
            
            C1: begin
                
                next_state = (w) ? D2 : D1;
                
            end
            
            D0: begin
                
                next_state = (w) ? B0 : B0;
                
            end
            
            D1: begin
                
                next_state = (w) ? B1 : B0;
                
            end
            
            D2: begin
                
                next_state = (w) ? B0 : B1;
            
            end
            
            default: begin
                
                next_state = A;
                
            end
            
        endcase
        
    end
    
    always @(posedge clk) begin
        
        if(reset) begin
            present_state <= A;
        end
        
        else begin
            present_state <= next_state;
        end
        
    end
    
    assign z = (present_state == B1);

endmodule
