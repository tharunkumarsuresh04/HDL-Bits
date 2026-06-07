module top_module (
    input clk,
    input x,
    output z
); 
    reg q_1, q_2, q_3;
    always @(posedge clk) begin
        
        q_1 <= q_1 ^ x;
        
        q_2 <= ~q_2 & x;
        
        q_3 <= ~q_3 | x;
               
    end
    
    initial begin
        q_1 = 1'b0;
        q_2 = 1'b0;
        q_3 = 1'b0;
    end
    
    assign z = ~(q_1 | q_2 | q_3);
    
    
    
endmodule
