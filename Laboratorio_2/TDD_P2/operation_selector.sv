module operation_selector (
    input logic [3:0] key,  // 4 botones para seleccionar la operación
    output logic [3:0] opcode // Valor de opcode para la ALU
);

    always_comb begin
        case (key)
            4'b0001: opcode = 4'b0000; // Botón 1: Suma
            4'b0010: opcode = 4'b0001; // Botón 2: Resta
            4'b0100: opcode = 4'b0010; // Botón 3: Multiplicación
            4'b1000: opcode = 4'b0011; // Botón 4: División
            4'b0101: opcode = 4'b0100; // Botón 1: Módulo
            4'b0011: opcode = 4'b0101; // Botón 2: AND
            4'b0110: opcode = 4'b0110; // Botón 3: OR
            4'b1100: opcode = 4'b0111; // Botón 4: XOR
            4'b0111: opcode = 4'b1000; // Botón 1: Shift left
            4'b1110: opcode = 4'b1001; // Botón 2: Shift right
            default: opcode = 4'b0000; // Por defecto: Suma
        endcase
    end

endmodule
