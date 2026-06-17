module top_module (
    input clk,
    input resetn,    // active-low synchronous reset
    input x,
    input y,
    output f,
    output g
);

    parameter START=0, F_ON=1, SEARCH=2, S1=3, S10=4;
    parameter G_ON1=5, G_ON2=6, PERM_G1=7, PERM_G0=8;
    
    reg [3:0] state, next;

    // Combinational Phase Execution
    always @(*) begin
        case(state)
            // Phase 1: Initialization
            START: next = F_ON;
            F_ON:  next = SEARCH;
            
            // Phase 2: Sequence Detection (101)
            SEARCH: next = x ? S1 : SEARCH;
            S1:     next = x ? S1 : S10;
            S10:    next = x ? G_ON1 : SEARCH;
            
            // Phase 3: Timeout Monitoring (y=1 within 2 cycles)
            G_ON1: next = y ? PERM_G1 : G_ON2;
            G_ON2: next = y ? PERM_G1 : PERM_G0;
            
            // Phase 4: Terminal Locks
            PERM_G1: next = PERM_G1;
            PERM_G0: next = PERM_G0;
            default: next = START;
        endcase
    end

    // Synchronous Active-Low Reset Update
    always @(posedge clk) begin
        if (~resetn) state <= START;
        else         state <= next;
    end

    // Datapath Mapping
    assign f = (state == F_ON);
    assign g = (state == G_ON1) | (state == G_ON2) | (state == PERM_G1);

endmodule
