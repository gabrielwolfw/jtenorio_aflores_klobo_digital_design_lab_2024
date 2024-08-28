module alu_tb;

    // Declarar señales de entrada y salida
    logic [3:0] a, b;                         // Cambiado a 4 bits
    logic [3:0] alu_op;                       // Cambiado a 4 bits
    logic [3:0] result;                      // Cambiado a 4 bits
    logic N, Z, C, V;

    // Declarar señales esperadas para la comprobación
    logic [3:0] expected_result;             // Cambiado a 4 bits
    logic expected_N, expected_Z, expected_C, expected_V;

    // Instancia del módulo ALU
    alu uut (
        .a(a),
        .b(b),
        .opcode(alu_op),                     // Cambiado a opcode
        .result(result),
        .N(N),
        .Z(Z),
        .C(C),
        .V(V)
    );

    // Procedimiento de prueba
    initial begin
        // Prueba de suma
        a = 4'b0011; b = 4'b0010; alu_op = 4'b0000;
        expected_result = 4'b0101;
        expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
        #10;
        check_result();

        // Prueba de resta
        a = 4'b0111; b = 4'b0011; alu_op = 4'b0001;
        expected_result = 4'b0100;
        expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
        #10;
        check_result();

        // Prueba de multiplicación
        a = 4'b0010; b = 4'b0011; alu_op = 4'b0010;
        expected_result = 4'b0110;
        expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
        #10;
        check_result();

        // Prueba de AND
        a = 4'b1111; b = 4'b1110; alu_op = 4'b0101;
        expected_result = 4'b1110;
        expected_N = 1; expected_Z = 0; expected_C = 0; expected_V = 0;
        #10;
        check_result();

        // Prueba de OR
        a = 4'b1111; b = 4'b0000; alu_op = 4'b0110;
        expected_result = 4'b1111;
        expected_N = 1; expected_Z = 0; expected_C = 0; expected_V = 0;
        #10;
        check_result();

        // Prueba de XOR
        a = 4'b1100; b = 4'b0011; alu_op = 4'b0111;
        expected_result = 4'b1111;
        expected_N = 1; expected_Z = 0; expected_C = 0; expected_V = 0;
        #10;
        check_result();

        // Prueba de shift left
        a = 4'b0001; b = 4'b0010; alu_op = 4'b1000;
        expected_result = 4'b0100;
        expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
        #10;
        check_result();

        // Prueba de shift right
        a = 4'b1000; b = 4'b0010; alu_op = 4'b1001;
        expected_result = 4'b0010;
        expected_N = 0; expected_Z = 0; expected_C = 0; expected_V = 0;
        #10;
        check_result();

        // Finalizar simulación
        $finish;
    end

    // Tarea para verificar el resultado
    task check_result;
        if (result !== expected_result) $display("Error: resultado incorrecto! Esperado %b, obtenido %b", expected_result, result);
        if (N !== expected_N) $display("Error: bandera N incorrecta! Esperado %b, obtenido %b", expected_N, N);
        if (Z !== expected_Z) $display("Error: bandera Z incorrecta! Esperado %b, obtenido %b", expected_Z, Z);
        if (C !== expected_C) $display("Error: bandera C incorrecta! Esperado %b, obtenido %b", expected_C, C);
        if (V !== expected_V) $display("Error: bandera V incorrecta! Esperado %b, obtenido %b", expected_V, V);
    endtask

endmodule



