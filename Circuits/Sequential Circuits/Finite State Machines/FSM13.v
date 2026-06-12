module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

    // State Parameter Encodings (3 bits handle up to 8 states)
    parameter WALK_LEFT  = 3'b000;
    parameter WALK_RIGHT = 3'b001;
    parameter FALL_LEFT  = 3'b010;
    parameter FALL_RIGHT = 3'b011;
    parameter DIG_LEFT   = 3'b100;
    parameter DIG_RIGHT  = 3'b101;
    parameter SPLATTERED = 3'b110;

    reg [2:0] state, next_state;
    reg [4:0] fall_count; // 5-bit counter tracks up to 31 cycles

    // 1. Combinational Block: Next State Decoder Tree
    always @(*) begin
        case (state)
            WALK_LEFT: begin
                if (!ground)     next_state = FALL_LEFT;
                else if (dig)    next_state = DIG_LEFT;
                else             next_state = (bump_left) ? WALK_RIGHT : WALK_LEFT;
            end

            WALK_RIGHT: begin
                if (!ground)     next_state = FALL_RIGHT;
                else if (dig)    next_state = DIG_RIGHT;
                else             next_state = (bump_right) ? WALK_LEFT : WALK_RIGHT;
            end

            DIG_LEFT: begin
                if (!ground)     next_state = FALL_LEFT;
                else             next_state = DIG_LEFT;
            end

            DIG_RIGHT: begin
                if (!ground)     next_state = FALL_RIGHT;
                else             next_state = DIG_RIGHT;
            end

            FALL_LEFT: begin
                if (ground)      next_state = (fall_count > 20) ? SPLATTERED : WALK_LEFT;
                else             next_state = FALL_LEFT;
            end

            FALL_RIGHT: begin
                if (ground)      next_state = (fall_count > 20) ? SPLATTERED : WALK_RIGHT;
                else             next_state = FALL_RIGHT;
            end

            SPLATTERED: begin
                next_state = SPLATTERED; // Infinite loop until areset is asserted
            end

            default: begin
                next_state = WALK_LEFT;
            end
        endcase
    end

    // 2. Sequential Block: State Register and Fall Counter Control
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state      <= WALK_LEFT;
            fall_count <= 5'd0;
        end else begin
            state <= next_state;
            
            // Counter management tracks the upcoming clock cycle state target
            if (next_state == FALL_LEFT || next_state == FALL_RIGHT) begin
                if (fall_count < 5'd31) begin
                    fall_count <= fall_count + 5'd1;
                end
            end else begin
                fall_count <= 5'd0; // Flush counter instantly upon landing or resetting
            end
        end
    end

    // 3. Moore Output Assignments: Evaluated exclusively from active state bits
    assign walk_left  = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah       = (state == FALL_LEFT || state == FALL_RIGHT);
    assign digging    = (state == DIG_LEFT  || state == DIG_RIGHT);

endmodule
