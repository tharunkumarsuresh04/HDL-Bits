module top_module(
    input clk,
    input in,
    input areset,
    output out); //

    
    parameter A = 2'b00, B = 2'b01, C = 2'b10, D = 2'b11;
    reg [1:0] present_state, next_state;
    // State transition logic
    always @(*) begin 
        case (present_state) 
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
   
   // State flip-flops with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            present_state <= A;
        end
        else begin
            present_state <= next_state;
        end
    end
    // Output logic
    assign out = (present_state == D);

endmodule
