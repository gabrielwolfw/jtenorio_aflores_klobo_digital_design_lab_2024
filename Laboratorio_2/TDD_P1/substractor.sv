module subtractor (
    input logic [3:0] a, b,                  // Cambiado a 4 bits
    output logic [3:0] result,               // Cambiado a 4 bits
    output logic borrow, overflow
);

    logic [3:0] b_complement;
    logic [3:0] sum_result;
    logic carry_out;

    // Calcular el complemento a 1 de b
    logic [3:0] b_not;
    assign b_not = ~b;

    // Sumar 1 al complemento a 1 - Complemento a 2
    adder add_1_to_complement (
        .a(b_not),
        .b(4'b0001),          // Sumar 1
        .result(b_complement),
        .carry(),             
        .overflow()           
    );

    // Sumar a y b_complement para obtener el resultado de la resta
    adder subtract_add (
        .a(a),
        .b(b_complement),
        .result(result),
        .carry(carry_out),
        .overflow(overflow)
    );

    assign borrow = ~carry_out;

endmodule
