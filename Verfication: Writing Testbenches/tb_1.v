module top_module ( 
    output reg A, 
    output reg B 
);

    // Generate asynchronous input patterns
    initial begin
        A = 1'b0; B = 1'b0; // t = 0
        
        #10 A = 1'b1;       // t = 10
        
        #5  B = 1'b1;       // t = 15
        
        #5  A = 1'b0;       // t = 20
        
        #20 B = 1'b0;       // t = 40
    end

endmodule
