module alu #(
    parameter WIDTH = 4  // Tamaño de los operandos
)(
    input logic [WIDTH-1:0] a, b,                     // Entradas parametrizables
    input logic [3:0] opcode,                         // Opcode de 4 bits
    output logic [WIDTH-1:0] result,                  // Resultado parametrizable
    output logic N, Z, C, V
);

    logic [WIDTH-1:0] sum, diff, prod, quotient, remainder;
    logic [WIDTH-1:0] and_res, or_res, xor_res, shl_res, shr_res;
    logic carry_out, overflow_sum, overflow_diff;

    // Instancias de módulos estructurales
    adder #(
        .WIDTH(WIDTH)
    ) add_unit (
        .a(a),
        .b(b),
        .result(sum),
        .carry(carry_out),
        .overflow(overflow_sum)
    );

    subtractor #(
        .WIDTH(WIDTH)
    ) sub_unit (
        .a(a),
        .b(b),
        .result(diff),
        .borrow(), // No usamos borrow en este contexto
        .overflow(overflow_diff)
    );

    multiplier #(
        .WIDTH(WIDTH)
    ) mul_unit (
        .a(a),
        .b(b),
        .result(prod)
    );

    // Operaciones lógicas y shifts
    assign and_res = a & b;
    assign or_res = a | b;
    assign xor_res = a ^ b;
    assign shl_res = a << b[WIDTH-1:0];  // Limitamos el shift a un valor de 0-15
    assign shr_res = a >> b[WIDTH-1:0];

    // Operaciones de división y módulo
    assign quotient = b != 0 ? a / b : {WIDTH{1'b0}}; // Protección contra división por cero
    assign remainder = b != 0 ? a % b : {WIDTH{1'b0}}; // Protección contra división por cero

    // Selección de la operación basada en opcode
    always_comb begin
        case (opcode)
            4'b0000: result = sum;          // Suma
            4'b0001: result = diff;         // Resta
            4'b0010: result = prod;         // Multiplicación
            4'b0011: result = quotient;     // División
            4'b0100: result = remainder;    // Módulo
            4'b0101: result = and_res;      // AND
            4'b0110: result = or_res;       // OR
            4'b0111: result = xor_res;      // XOR
            4'b1000: result = shl_res;      // Shift left
            4'b1001: result = shr_res;      // Shift right
            default: result = {WIDTH{1'b0}}; // Default
        endcase
    end

    // Cálculo de banderas
    assign N = result[WIDTH-1];               // Negativo: 1 si el bit más significativo es 1
    assign Z = (result == {WIDTH{1'b0}});    // Cero: 1 si el resultado es 0
    assign C = (opcode == 4'b0000) ? carry_out : // Acarreo para Suma
               (opcode == 4'b1000) ? a[WIDTH-1] : // Acarreo para Shift Left
               (opcode == 4'b1001) ? a[0] : 1'b0; // Acarreo para Shift Right
    assign V = (opcode == 4'b0000) ? overflow_sum : // Desbordamiento para Suma
               (opcode == 4'b0001) ? overflow_diff : 1'b0; // Desbordamiento para Resta

endmodule
