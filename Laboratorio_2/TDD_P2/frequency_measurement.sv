module frequency_measurement #(
    parameter WIDTH = 32  // Ancho de los operandos y resultados
)(
    input logic clk,                // Reloj del sistema
    input logic reset,              // Reset del sistema
    input logic [WIDTH-1:0] a, b,   // Entradas para la ALU
    input logic [3:0] opcode,       // Código de operación para la ALU
    output logic [WIDTH-1:0] result,// Resultado de la ALU
    output logic N, Z, C, V         // Banderas de la ALU
);

    // Señales internas
    logic [WIDTH-1:0] reg_a, reg_b;
    logic [WIDTH-1:0] alu_result;
    logic alu_N, alu_Z, alu_C, alu_V;

    // Instancia del registro de entrada
    register #(.WIDTH(WIDTH)) reg_a_inst (
        .clk(clk),
        .reset(reset),
        .d(a),
        .q(reg_a)
    );

    register #(.WIDTH(WIDTH)) reg_b_inst (
        .clk(clk),
        .reset(reset),
        .d(b),
        .q(reg_b)
    );

    // Instancia del módulo ALU
    alu #(
        .WIDTH(WIDTH)
    ) alu_instance (
        .a(reg_a),
        .b(reg_b),
        .opcode(opcode),
        .result(alu_result),
        .N(alu_N),
        .Z(alu_Z),
        .C(alu_C),
        .V(alu_V)
    );

    // Instancia del registro de salida
    register #(.WIDTH(WIDTH)) reg_out_inst (
        .clk(clk),
        .reset(reset),
        .d(alu_result),
        .q(result)
    );

    // Instancia de registros para banderas
    register #(.WIDTH(1)) reg_N_inst (
        .clk(clk),
        .reset(reset),
        .d(alu_N),
        .q(N)
    );

    register #(.WIDTH(1)) reg_Z_inst (
        .clk(clk),
        .reset(reset),
        .d(alu_Z),
        .q(Z)
    );

    register #(.WIDTH(1)) reg_C_inst (
        .clk(clk),
        .reset(reset),
        .d(alu_C),
        .q(C)
    );

    register #(.WIDTH(1)) reg_V_inst (
        .clk(clk),
        .reset(reset),
        .d(alu_V),
        .q(V)
    );

endmodule

