module adder #(
    parameter WIDTH = 4  // Tamaño de la palabra, por defecto es 4 bits
)(
    input logic [WIDTH-1:0] a, b,                // Entradas de WIDTH bits
    output logic [WIDTH-1:0] result,             // Resultado de WIDTH bits
    output logic carry, overflow
);

    logic [WIDTH-1:0] carry_out;                 // Acarreos intermedios
    logic cin;

    assign cin = 1'b0; // No carry-in para el primer bit

    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : adder_block
            if (i == 0) begin
                full_adder #(
                    .WIDTH(1)  // Para el full adder, WIDTH es 1 bit
                ) fa (
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cin),
                    .sum(result[i]),
                    .cout(carry_out[i])
                );
            end else begin
                full_adder #(
                    .WIDTH(1)  // Para el full adder, WIDTH es 1 bit
                ) fa (
                    .a(a[i]),
                    .b(b[i]),
                    .cin(carry_out[i-1]),
                    .sum(result[i]),
                    .cout(carry_out[i])
                );
            end
        end
    endgenerate

    assign carry = carry_out[WIDTH-1];           // Acarreo de salida
    assign overflow = (a[WIDTH-1] == b[WIDTH-1]) && (result[WIDTH-1] != a[WIDTH-1]);

endmodule

