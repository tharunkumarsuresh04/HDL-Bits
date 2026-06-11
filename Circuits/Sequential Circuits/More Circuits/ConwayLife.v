module top_module (
    input clk,
    input load,
    input [255:0] data,
    output reg [255:0] q
);

    // Combinational register array to hold computed next-state values
    reg [255:0] next_q;
    
    // Loop iterators and temporary arithmetic variables
    integer r, c;
    integer r_up, r_down, c_left, c_right;
    integer live_neighbors;

    // 1. Combinational Block: Evaluating neighbors for all 256 cells simultaneously
    always @(*) begin
        for (r = 0; r < 16; r = r + 1) begin
            for (c = 0; c < 16; c = c + 1) begin
                
                // Toroidal Boundary Wrapping using constant ternary operators
                r_up    = (r == 0)  ? 15 : r - 1;
                r_down  = (r == 15) ? 0  : r + 1;
                c_left  = (c == 0)  ? 15 : c - 1;
                c_right = (c == 15) ? 0  : c + 1;
                
                // Accumulate the count of active live neighbors from the flat vector array
                live_neighbors = q[r_up   * 16 + c_left]  + q[r_up   * 16 + c]  + q[r_up   * 16 + c_right] +
                                 q[r      * 16 + c_left]  +                         q[r      * 16 + c_right] +
                                 q[r_down * 16 + c_left]  + q[r_down * 16 + c]  + q[r_down * 16 + c_right];
                
                // State Transition Logic Matrix
                if (live_neighbors == 3) begin
                    next_q[r * 16 + c] = 1'b1;         // Reproduction or Stable Living
                end 
                else if (live_neighbors == 2) begin
                    next_q[r * 16 + c] = q[r * 16 + c]; // Hold existing state
                end 
                else begin
                    next_q[r * 16 + c] = 1'b0;         // Underpopulation or Overpopulation Death
                end
            end
        end
    end

    // 2. Sequential Block: Updating the state elements at the clock edge
    always @(posedge clk) begin
        if (load) begin
            // Synchronous parallel initialization pattern load
            q <= data;
        end else begin
            // Advance state space by one step per cycle
            q <= next_q;
        end
    end

endmodule
