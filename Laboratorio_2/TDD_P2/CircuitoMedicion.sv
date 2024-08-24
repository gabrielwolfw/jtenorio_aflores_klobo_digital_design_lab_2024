module CircuitoMedicion #(parameter N = 4) (
    input clk, reset,
    input [N-1:0] a, b,
    input [3:0] operation,
    output [N-1:0] out,
    output outFlagC, outFlagN, outFlagV, outFlagZ,
    output [6:0] segA
);
    wire [N-1:0] reg1_out, reg2_out, alu_result;

    // Instancia del primer registro
    Register #(N) reg1 (
        .clk(clk),
        .reset(reset),
        .d(a),
        .q(reg1_out)
    );

    // Instancia de la ALU
    ALU #(N) alu1 (
        .a(reg1_out),
        .b(b),
        .operation(operation),
        .outFlagC(outFlagC),
        .outFlagN(outFlagN),
        .outFlagV(outFlagV),
        .outFlagZ(outFlagZ),
        .segA(alu_result)
    );

    // Instancia del segundo registro
    Register #(N) reg2 (
        .clk(clk),
        .reset(reset),
        .d(alu_result),
        .q(reg2_out)
    );

    assign out = reg2_out;
endmodule

