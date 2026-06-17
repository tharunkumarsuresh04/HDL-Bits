module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    reg [1:0] present_state, next_state;
    
    parameter A = 2'b00, B = 2'b01, C = 2'b10;
        
    always @(*) begin
        
        case (present_state) 
            A: begin
                next_state = (x) ? B : A;
            end
            
            B: begin
                next_state = (x) ? C : B;
            end
            
            C: begin
                next_state = (x) ? C : B;
            end
            
            default: begin
                next_state = A;
            end
            
        endcase 
    end
               
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            present_state <= A;
        end
        else begin
            present_state <= next_state;
        end
    end
    
    assign z = (present_state == B);
            

endmodule
