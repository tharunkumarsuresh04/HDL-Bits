module top_module (
    input [7:0] code,
    output reg [3:0] out,
    output reg valid 
);

    always @(*) begin
        // FIX: Assign default values at the top of the block.
        // This guarantees NO latches will be inferred, regardless of the case branches.
        out = 4'd0;
        valid = 1'b1;

        case (code)
            8'h45: out = 4'd0;
            8'h16: out = 4'd1;
            8'h1e: out = 4'd2;
            8'h26: out = 4'd3; // FIX: Changed from decimal (8'd26) to hex
            8'h25: out = 4'd4;
            8'h2e: out = 4'd5;
            8'h36: out = 4'd6;
            8'h3d: out = 4'd7;
            8'h3e: out = 4'd8;
            8'h46: out = 4'd9; // FIX: Corrected vector width from 6 to 8 bits
            default: begin
                valid = 1'b0; // Overrides the default high valid flag if key is unknown
            end
        endcase
    end

endmodule
