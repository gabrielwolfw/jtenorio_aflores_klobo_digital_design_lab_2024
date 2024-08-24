module subtractor (
    input logic [3:0] a, b,                  // Cambiado a 4 bits
    output logic [3:0] result,               // Cambiado a 4 bits
    output logic borrow, overflow
);

    logic [3:0] b_complement;
    logic carry_out;

    // Calcular el complemento a 2 de b
    assign b_complement = ~b + 1;

    adder add (
        .a(a),
        .b(b_complement),
        .result(result),
        .carry(carry_out),
        .overflow(overflow)
    );

    assign borrow = ~carry_out;

endmodule
