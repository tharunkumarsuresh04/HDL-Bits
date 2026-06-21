module top_module (
    input a, 
    input b, 
    input c, 
    output out
);

    wire and_out; // Internal wire to catch the AND gate output

    // FIX: Use explicit named port mapping and tie unused AND inputs high
    andgate inst1 (
        .out(and_out),
        .a(a),
        .b(b),
        .c(c),
        .d(1'b1), // Neutralize extra inputs
        .e(1'b1)
    );

    // FIX: Invert the result to create the NAND logic
    assign out = ~and_out;

endmodule
