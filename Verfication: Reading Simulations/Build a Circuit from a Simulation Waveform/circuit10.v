module top_module (
    input clk,
    input a,
    input b,
    output q,
    output reg state  );

    assign q = a ^ b ^ state;
    	
    always @(posedge clk) begin
        		
        state <= a & b | a & state | b & state; 
        
    end
        
endmodule
