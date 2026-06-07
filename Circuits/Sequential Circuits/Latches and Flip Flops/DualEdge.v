module top_module (
    input clk,
    input d,
    output q
);
    
    reg pos, neg;
    
    always @(posedge clk) begin
        pos <= d ^ neg;
    end
    
    always @(negedge clk) begin
        neg <= d ^ pos;
    end
    
    assign q = pos ^ neg;

endmodule
