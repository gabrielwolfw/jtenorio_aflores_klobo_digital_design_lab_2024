module CircuitoMedicion #(parameter N = 4) (
    input wire clk,
    input wire reset,
    input wire [N-1:0] in_a,
    input wire [N-1:0] in_b,
    input wire [3:0] operation,
    output wire [N-1:0] out,
    output wire outFlagC,
    output wire outFlagN,
    output wire outFlagV,
    output wire outFlagZ,
    output wire [6:0] segA
);
    wire [N-1:0] reg1_out;
    wire [N-1:0] alu_out;

    // Primer registro
    Register #(N) reg1 (
        .clk(clk),
        .reset(reset),
        .D(in_a),
        .Q(reg1_out)
    );

    // ALU
    ALU #(N) alu1 (
        .a(reg1_out),
        .b(in_b),
        .operation(operation),
        .outFlagC(outFlagC),
        .outFlagN(outFlagN),
        .outFlagV(outFlagV),
        .outFlagZ(outFlagZ),
        .segA(segA)
    );

    // Segundo registro
    Register #(N) reg2 (
        .clk(clk),
        .reset(reset),
        .D(alu_out),
        .Q(out)
    );
endmodule
