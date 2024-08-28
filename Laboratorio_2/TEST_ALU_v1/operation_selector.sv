module operation_selector (
    input logic [3:0] key,  // 4 botones para seleccionar la operación
    output logic [3:0] opcode // Valor de opcode para la ALU
);

    always_comb begin
        case (key)
            4'b0000: opcode = 4'b1111; // Botón 0: Suma
            4'b0001: opcode = 4'b1110; // Botón 1: Resta
            4'b0010: opcode = 4'b1101; // Botón 2: Multiplicación
            4'b0011: opcode = 4'b1100; // Botón 3: División
            default: opcode = 4'b1111; // Por defecto: Suma
        endcase
    end

endmodule
