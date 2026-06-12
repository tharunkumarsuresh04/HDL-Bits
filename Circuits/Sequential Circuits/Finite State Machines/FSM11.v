module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter WALK_LEFT = 2'b00, WALK_RIGHT = 2'b01, FALL_LEFT = 2'b10, FALL_RIGHT = 2'b11;

    reg [1:0] present_state, next_state;
    
    always@(*) begin
        
        case (present_state) 
            WALK_LEFT: begin
                
                if(!ground) begin
                    next_state = FALL_LEFT;
                end
                
                else begin
                    next_state = (bump_left) ? WALK_RIGHT : WALK_LEFT;
                end
                
            end
            
            WALK_RIGHT: begin
                
                if (!ground) begin
                    next_state = FALL_RIGHT;
                end
                
                else begin
                    next_state = (bump_right) ? WALK_LEFT : WALK_RIGHT;
                end
                
            end
        
            FALL_LEFT: begin
                next_state = (ground) ? WALK_LEFT : FALL_LEFT;
            end
            
            FALL_RIGHT: begin
                next_state = (ground) ? WALK_RIGHT : FALL_RIGHT;
            end
            
            default: begin
                next_state = WALK_LEFT;
            end
            
        endcase
        
    end
    
    
    always @(posedge clk or posedge areset) begin
        
        if(areset) begin
            present_state <= WALK_LEFT;
        end
        
        else begin
            present_state <= next_state;
        end
        
    end
    
    
    assign walk_left = (present_state == WALK_LEFT) ;
    assign walk_right = (present_state == WALK_RIGHT) ;
    assign aaah = (present_state == FALL_LEFT) | (present_state == FALL_RIGHT) ;

endmodule
