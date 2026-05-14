/*
You are given a module my_dff with two inputs and one output (that implements a D flip-flop). Instantiate three of them, then chain them together to make a shift register of length 3. 
The clk port needs to be connected to all instances.

The module provided to you is: module my_dff ( input clk, input d, output q );

Note that to make the internal connections, you will need to declare some wires. Be careful about naming your wires and module instances: the names must be unique.
*/

module top_module ( input clk, input d, output q );

    wire w1, w2;
    
    my_dff dff_inst1 (.clk(clk), .d(d), .q(w1));
    
    my_dff dff_inst2 (.clk(clk), .d(w1), .q(w2));
    
    my_dff dff_inst3 (.clk(clk), .d(w2), .q(q));
    
endmodule
