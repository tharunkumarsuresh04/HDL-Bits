module top_module (
    input clk,
    input areset,
    input x,
    output z
); 
    
    parameter A = 2'b01, B = 2'b10;
    reg [1:0] present_state, next_state;
    
    always @(*) begin
        
        next_state [0] = (present_state[0] & ~x);
        
        next_state[1] = (present_state[0] & x) | present_state[1];
        
    end
    
    always @(posedge clk or posedge areset) begin
        
        if(areset) begin
            present_state <= A;
        end
        
        else begin
            present_state <= next_state;
        end
    end
    
    assign z = (present_state[0] & x) | (present_state[1] & ~x);

endmodule
