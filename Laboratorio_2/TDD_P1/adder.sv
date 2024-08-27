module adder #(
    parameter WIDTH = 4  // Parametro para definir el ancho de los buses
)(
    input logic [WIDTH-1:0] a, b,          // Ancho de bits parametrizado
    output logic [WIDTH-1:0] result,       // Ancho de bits parametrizado
    output logic carry, overflow
);

    logic [WIDTH-1:0] carry_out;           // Ancho de bits parametrizado
    logic cin;

    assign cin = 1'b0; // No carry-in para el primer bit

    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : adder_block // Iteraciones parametrizadas
            if (i == 0) begin
                full_adder fa (
                    .a(a[i]),
                    .b(b[i]),
                    .cin(cin),
                    .sum(result[i]),
                    .cout(carry_out[i])
                );
            end else begin
                full_adder fa (
                    .a(a[i]),
                    .b(b[i]),
                    .cin(carry_out[i-1]),
                    .sum(result[i]),
                    .cout(carry_out[i])
                );
            end
        end
    endgenerate

    assign carry = carry_out[WIDTH-1]; // Último bit parametrizado
    assign overflow = (a[WIDTH-1] == b[WIDTH-1]) && (result[WIDTH-1] != a[WIDTH-1]);

endmodule
