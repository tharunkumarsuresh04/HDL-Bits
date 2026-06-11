module top_module(
    input in,
    input [1:0] state,
    output [1:0] next_state,
    output out); //

    parameter A=2'b00, B=2'b01, C=2'b10, D=2'b11;

    // State transition logic: next_state = f(state, in)
    always @(*) begin
        case (state) 
            A: begin
                next_state = (in == 1'b1) ? B : A;
            end
            B: begin
                next_state = (in == 1'b1) ? B : C;
            end
            C: begin
                next_state = (in == 1'b1) ? D : A; 
            end
            D: begin
                next_state = (in == 1'b1) ? B : C;
            end
            default: begin
                next_state = A;
            end
        endcase
    end
    
    assign out = (state == D);
    // Output logic:  out = f(state) for a Moore state machine

endmodule
