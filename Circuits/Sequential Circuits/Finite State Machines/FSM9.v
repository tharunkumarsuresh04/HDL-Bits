module top_module (
    input clk,
    input reset,
    input [3:1] s,
    output fr3,
    output fr2,
    output fr1,
    output dfr
); 
    parameter BELOW_S1 = 3'b000;
    parameter BETWEEN_S1_AND_S2_RISING = 3'b001;
    parameter BETWEEN_S1_AND_S2_FALLING = 3'b010;
    parameter BETWEEN_S2_AND_S3_RISING = 3'b011;
    parameter BETWEEN_S2_AND_S3_FALLING = 3'b100;
    parameter ABOVE_S3 = 3'b101;
    
    reg [2:0] present_state, next_state;
    
    always @(*) begin
        
        case (present_state)
            BELOW_S1: begin
                if(s[1]) begin
                    next_state = BETWEEN_S1_AND_S2_RISING;
                end
                else begin
                    next_state = BELOW_S1;
                end
            end
                
            BETWEEN_S1_AND_S2_RISING: begin
                if(s[2]) begin
                    next_state = BETWEEN_S2_AND_S3_RISING;
                end
                else if (!s[1]) begin
                    next_state = BELOW_S1; 
                end 
                else begin
                    next_state = BETWEEN_S1_AND_S2_RISING;
                end
            end
                
            BETWEEN_S1_AND_S2_FALLING: begin
                if(s[2]) begin
                    next_state = BETWEEN_S2_AND_S3_RISING;
                end 
                else if (!s[1]) begin 
                    next_state = BELOW_S1; 
                end
                else begin
                    next_state = BETWEEN_S1_AND_S2_FALLING;
                end
                
            end
                
            BETWEEN_S2_AND_S3_RISING: begin
                if(s[3]) begin
                    next_state = ABOVE_S3; 
                end
                else if (!s[2]) begin
                    next_state = BETWEEN_S1_AND_S2_FALLING;
                end
                else begin
                    next_state = BETWEEN_S2_AND_S3_RISING;
                end
            end
                
            BETWEEN_S2_AND_S3_FALLING: begin
                if (s[3]) begin
                    next_state = ABOVE_S3; 
                end
                else if (!s[2]) begin
                    next_state = BETWEEN_S1_AND_S2_FALLING;
                end
                else begin
                    next_state = BETWEEN_S2_AND_S3_FALLING;
                end
            end
                
            ABOVE_S3: begin
                if (!s[3]) begin
                    next_state = BETWEEN_S2_AND_S3_FALLING;
                end
                else begin
                    next_state = ABOVE_S3;
                end
            end
          
        endcase
    end
 
    
    
    always @(posedge clk) begin
        
        if(reset) begin
            present_state <= BELOW_S1;
        end
        else begin
            present_state <= next_state;
        end
    end
    
    always @(*) begin
        fr1 = 1'b0;
        fr2 = 1'b0;
        fr3 = 1'b0;
        dfr = 1'b0;
        
        case (present_state)
            BELOW_S1: begin
                fr1 = 1'b1; fr2 = 1'b1; fr3 = 1'b1; dfr = 1'b1;
            end
            BETWEEN_S1_AND_S2_RISING: begin
                fr1 = 1'b1; fr2 = 1'b1; fr3 = 1'b0; dfr = 1'b0;
            end
            BETWEEN_S1_AND_S2_FALLING: begin
                fr1 = 1'b1; fr2 = 1'b1; fr3 = 1'b0; dfr = 1'b1;
            end
            BETWEEN_S2_AND_S3_RISING: begin
                fr1 = 1'b1; fr2 = 1'b0; fr3 = 1'b0; dfr = 1'b0;
            end
            BETWEEN_S2_AND_S3_FALLING: begin
                fr1 = 1'b1; fr2 = 1'b0; fr3 = 1'b0; dfr = 1'b1;
            end
            ABOVE_S3: begin
                fr1 = 1'b0; fr2 = 1'b0; fr3 = 1'b0; dfr = 1'b0;
            end
        endcase
    end

endmodule
