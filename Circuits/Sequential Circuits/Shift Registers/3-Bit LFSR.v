module top_module (
	input [2:0] SW,      // R
	input [1:0] KEY,     // L and clk
	output [2:0] LEDR);  // Q
    
    reg [2:0] Q;
    
    assign LEDR = Q;
    
    always @(posedge KEY[0]) begin
        if (KEY[1]) begin 
            Q[0] <= SW[0];
            Q[1] <= SW[1];
            Q[2] <= SW[2];
        end
        else begin
            Q[0] <= Q[2];
            Q[1] <= Q[0];
            Q[2] <= Q[1] ^ Q[2];            
        end
    end

endmodule
