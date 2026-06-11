module top_module (
    input [3:0] SW,
    input [3:0] KEY,
    output [3:0] LEDR
); //
    
    MUXDFF Mux_DFF4 ( .clk(KEY[0]), 
                      .W(KEY[3]), 
                      .R(SW[3]), 
                      .E(KEY[1]), 
                      .L(KEY[2]), 
                      .Q(LEDR[3])
                    );
    MUXDFF Mux_DFF3 ( .clk(KEY[0]), 
                      .W(LEDR[3]), 
                      .R(SW[2]), 
                      .E(KEY[1]), 
                      .L(KEY[2]), 
                      .Q(LEDR[2])
                    );
    MUXDFF Mux_DFF2 ( .clk(KEY[0]), 
                      .W(LEDR[2]), 
                      .R(SW[1]), 
                      .E(KEY[1]), 
                      .L(KEY[2]), 
                      .Q(LEDR[1])
                    );
    MUXDFF Mux_DFF1 ( .clk(KEY[0]), 
                      .W(LEDR[1]), 
                      .R(SW[0]), 
                      .E(KEY[1]), 
                      .L(KEY[2]), 
                      .Q(LEDR[0])
                    );

endmodule

module MUXDFF (input clk, 
              input W, 
              input R, 
              input E, 
              input L, 
              output reg Q
              );
    
    always @(posedge clk) begin
        if (L) begin 
            Q <= R; 
        end
        else if (E) begin
            Q <= W;
        end
        else begin
            Q <= Q;
        end
    end

endmodule
