module subtractor #(
    parameter WIDTH = 4  // Parametro para definir el ancho de los buses
)(
    input logic [WIDTH-1:0] a, b,             // Ancho de bits parametrizado
    output logic [WIDTH-1:0] result,          // Ancho de bits parametrizado
    output logic borrow, overflow
);

    logic [WIDTH-1:0] b_complement;
    logic [WIDTH-1:0] sum_result;
    logic carry_out;

    // Calcular el complemento a 1 de b
    logic [WIDTH-1:0] b_not;
    assign b_not = ~b;

    // Sumar 1 al complemento a 1 - Complemento a 2
    adder #(.WIDTH(WIDTH)) add_1_to_complement (
        .a(b_not),
        .b({{WIDTH-1{1'b0}}, 1'b1}),  // Sumar 1 (con ancho parametrizable)
        .result(b_complement),
        .carry(),             
        .overflow()           
    );

    // Sumar a y b_complement para obtener el resultado de la resta
    adder #(.WIDTH(WIDTH)) subtract_add (
        .a(a),
        .b(b_complement),
        .result(result),
        .carry(carry_out),
        .overflow(overflow)
    );

    assign borrow = ~carry_out;

endmodule
