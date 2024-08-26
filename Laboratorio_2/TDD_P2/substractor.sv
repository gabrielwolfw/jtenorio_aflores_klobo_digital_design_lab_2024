module subtractor #(
    parameter WIDTH = 4  // Tamaño de la palabra, por defecto es 4 bits
)(
    input logic [WIDTH-1:0] a, b,                // Entradas de WIDTH bits
    output logic [WIDTH-1:0] result,             // Resultado de WIDTH bits
    output logic borrow, overflow
);

    logic [WIDTH-1:0] b_complement;
    logic [WIDTH-1:0] b_not;
    logic [WIDTH-1:0] one;                        // Usado para sumar 1 al complemento a 1
    logic carry_out;

    assign one = {WIDTH{1'b0}} + 1;               // Generar el valor 1 de WIDTH bits
    assign b_not = ~b;                            // Calcular el complemento a 1 de b

    // Sumar 1 al complemento a 1 - Complemento a 2
    adder #(
        .WIDTH(WIDTH)  // Usar el ancho parametrizado
    ) add_1_to_complement (
        .a(b_not),
        .b(one),          // Sumar 1
        .result(b_complement),
        .carry(),             
        .overflow()           
    );

    // Sumar a y b_complement para obtener el resultado de la resta
    adder #(
        .WIDTH(WIDTH)  // Usar el ancho parametrizado
    ) subtract_add (
        .a(a),
        .b(b_complement),
        .result(result),
        .carry(carry_out),
        .overflow(overflow)
    );

    assign borrow = ~carry_out;  // Calcular el borrow

endmodule

