module top_module;

    reg clk;
    
    // Instantiate the DUT
    dut u1 (
        .clk(clk)
    );
  
    initial begin
        clk = 1'b0;     
        forever #5 clk = ~clk; 
    end

endmodule
