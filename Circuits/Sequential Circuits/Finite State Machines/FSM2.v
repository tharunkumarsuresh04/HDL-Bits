// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations
	parameter A = 1'b0; 
    parameter B = 1'b1;
    
    reg present_state, next_state;

    always @(posedge clk) begin
        if (reset) begin  
            present_state = B;
            out = 1'b1;
            // Fill in reset logic
        end else begin
            case (present_state)
                B : begin
                    next_state = (in == 1'b1) ? B : A;
                end
                A: begin
                    next_state = (in == 1'b1) ? A : B;
                end
            endcase
                // Fill in state transition logic
                // State flip-flops
            present_state = next_state;   

            case (present_state)
                A : begin
                    out = 1'b0;
                end
                B : begin
                    out = 1'b1;
                end
                // Fill in output logic
            endcase
        end
    end

endmodule
