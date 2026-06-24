module top_module ();

    // Declare internal testbench wires and registers
    reg clk;
    reg reset;
    reg t;
    wire q;

    // Instantiate the Device Under Test (DUT)
    tff uut (
        .clk(clk),
        .reset(reset),
        .t(t),
        .q(q)
    );

    // Clock generator (10 unit period)
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // Stimulus process
    initial begin
        // 1. Establish known baseline via reset
        reset = 1'b1;
        t = 1'b0;
        #15; 
        
        // 2. Release reset
        reset = 1'b0;
        #10;
        
        // 3. Assert toggle for exactly one clock cycle
        t = 1'b1;
        #10;
        
        // 4. Hold new state
        t = 1'b0;
    end

endmodule
