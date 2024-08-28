module adder (
    input logic [3:0] a, b,                      // Cambiado a 4 bits
    output logic [3:0] result,                   // Cambiado a 4 bits
    output logic carry, overflow
);

    logic [3:0] carry_out;                       // Cambiado a 4 bits
    logic cin;

    assign cin = 1'b0; // No carry-in para el primer bit

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin : adder_block // Cambiado a 4 iteraciones
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

    assign carry = carry_out[3];                // Cambiado a 4 bits
    assign overflow = (a[3] == b[3]) && (result[3] != a[3]);

endmodule
