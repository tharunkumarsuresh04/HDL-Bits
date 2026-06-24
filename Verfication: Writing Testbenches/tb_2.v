module top_module();

    reg clk;
    reg in;
    reg [2:0] s;
    wire out;

    // Instantiate the DUT
    q7 uut (
        .clk(clk),
        .in(in),
        .s(s),
        .out(out)
    );

    // System Clock Generation
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Synchronous Stimulus Injection
    initial begin
        // t = 0
        in = 1'b0; 
        s = 3'd2;
        
        // t = 10
        #10;
        s = 3'd6;
        
        // t = 20
        #10;
        in = 1'b1; 
        s = 3'd2;
        
        // t = 30
        #10;
        in = 1'b0; 
        s = 3'd7;
        
        // t = 40
        #10;
        in = 1'b1; 
        s = 3'd0;
        
        // t = 70 (Hold previous state for 30 ticks)
        #30;
        in = 1'b0;
    end

endmodule
