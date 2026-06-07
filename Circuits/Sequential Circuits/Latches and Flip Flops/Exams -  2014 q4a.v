module top_module (
    input clk,
    input w, R, E, L,
    output Q
);
    wire mux_out;
    assign mux_out = E ? w : Q;
    
    always @(posedge clk) begin 
        if (L) begin
            Q <= R;
        end
        else begin
            Q <= mux_out;
        end
        
    end
    
endmodule
