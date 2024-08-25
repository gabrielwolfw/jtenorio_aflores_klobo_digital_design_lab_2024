module multiplier (
    input logic [3:0] a, b,                  // Entradas de 4 bits
    output logic [3:0] result                // Resultado de 4 bits
);

    logic [7:0] partial_sum[3:0];            // Sumas parciales
    logic [7:0] product;                     // Producto final de 8 bits

    // Instancias de partial_multiplier
    partial_multiplier pm0 (
        .a(a),
        .b(b[0]),
        .shift(2'd0),
        .result(partial_sum[0])
    );

    partial_multiplier pm1 (
        .a(a),
        .b(b[1]),
        .shift(2'd1),
        .result(partial_sum[1])
    );

    partial_multiplier pm2 (
        .a(a),
        .b(b[2]),
        .shift(2'd2),
        .result(partial_sum[2])
    );

    partial_multiplier pm3 (
        .a(a),
        .b(b[3]),
        .shift(2'd3),
        .result(partial_sum[3])
    );

    // Suma de los resultados parciales
    always_comb begin
        product = partial_sum[0] + partial_sum[1] + partial_sum[2] + partial_sum[3];
        result = product[3:0];  // Tomar solo los primeros 4 bits
    end

endmodule
