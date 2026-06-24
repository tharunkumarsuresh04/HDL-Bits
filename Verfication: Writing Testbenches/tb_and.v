module top_module ();

    // 1. Declare testbench variables
    reg [1:0] in;
    wire out;

    // 2. Instantiate the Device Under Test (DUT)
    andgate uut (
        .in(in),
        .out(out)
    );

    // 3. Exhaustive Truth Table Stimulus
    initial begin
        // t = 0
        in = 2'b00;
        
        // t = 10
        #10;
        in = 2'b01;
        
        // t = 20
        #10;
        in = 2'b10;
        
        // t = 30
        #10;
        in = 2'b11;
        
        // The simulation naturally terminates after the final execution step
    end

endmodule
