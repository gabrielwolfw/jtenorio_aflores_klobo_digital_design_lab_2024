module top (
    input logic [9:0] sw,    // 10 switches
    input logic [3:0] key,   // 4 botones
    output logic [6:0] seg1, // 7 segmentos para resultado (7 segmentos del primer display)
    output logic N_led, Z_led, C_led, V_led // LEDs para banderas
);

    logic [3:0] a, b, opcode, result;
    logic N, Z, C, V;

    // Conectar los switches a las entradas a y b
    assign a = sw[3:0]; // Los 4 primeros switches para a
    assign b = sw[7:4]; // Los siguientes 4 switches para b

    // Conectar los botones a las operaciones
    operation_selector op_selector (
        .key(key),
        .opcode(opcode)
    );

    // Instanciar la ALU
    alu my_alu (
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .N(N),
        .Z(Z),
        .C(C),
        .V(V)
    );

    // Convertir el resultado a señales de 7 segmentos
    bin_to_7seg result_to_7seg (
        .bin(result),
        .seg(seg1)
    );

    // Asignar las banderas a los LEDs
    assign N_led = N;
    assign Z_led = Z;
    assign C_led = C;
    assign V_led = V;

endmodule
