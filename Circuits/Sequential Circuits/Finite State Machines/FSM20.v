module top_module(
    input clk,
    input reset,    // Synchronous reset
    input in,
    output disc,
    output flag,
    output err);
    
    reg [3:0] present_state, next_state;
    
    parameter ZERO = 4'd0, ONE = 4'd1, TWO = 4'd2, THREE = 4'd3, FOUR = 4'd4, FIVE = 4'd5, SIX = 4'd6, ERROR = 4'd7, FLAG = 4'd8, DISCARD = 4'd9;
      
    always @(*) begin
        
        case (present_state) 
            
            ZERO: begin
                next_state = (in) ? ONE : ZERO;
            end
            
            ONE: begin
                next_state = (in) ? TWO : ZERO;
            end
            
            TWO: begin
                next_state = (in) ? THREE : ZERO;
            end
            
            THREE: begin
                next_state = (in) ? FOUR : ZERO;
            end
            
            FOUR: begin
                next_state = (in) ? FIVE : ZERO;
            end
            
            FIVE: begin
                next_state = (in) ? SIX : DISCARD;
            end
            
            SIX: begin
                next_state = (in) ? ERROR : FLAG;
            end
            
            ERROR: begin
                next_state = (in) ? ERROR : ZERO;
            end
            
            FLAG: begin
                next_state = (in) ? ONE : ZERO;
            end
            
            DISCARD: begin
                next_state = (in) ? ONE : ZERO;
            end
            
            default: begin
                next_state = ZERO;
            end
            
        endcase 
    end
    
    always @(posedge clk) begin
        
        if(reset) begin
            present_state <= ZERO;
        end
        
        else begin
            present_state <= next_state;
        end
    end
    
    assign disc = (present_state == DISCARD);
    assign flag = (present_state == FLAG);
    assign err = (present_state == ERROR);
            
            

endmodule
