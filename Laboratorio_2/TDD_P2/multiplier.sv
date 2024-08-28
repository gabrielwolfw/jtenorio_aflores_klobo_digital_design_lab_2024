module multiplier #(
    parameter WIDTH = 4  // Tamaño del multiplicando
)(
    input logic [WIDTH-1:0] a,                // Entradas parametrizables
    input logic [WIDTH-1:0] b,
    output logic [2*WIDTH-1:0] result         // Resultado parametrizable
);

    logic [2*WIDTH-1:0] partial_sum[WIDTH-1:0];  // Sumas parciales
    logic [2*WIDTH-1:0] product;                 // Producto final

    // Instancias de partial_multiplier
    generate
        genvar i;
        for (i = 0; i < WIDTH; i = i + 1) begin : gen_partial_multipliers
            partial_multiplier #(
                .WIDTH(WIDTH)
            ) pm (
                .a(a),
                .b(b[i]),
                .shift(i),
                .result(partial_sum[i])
            );
        end
    endgenerate

    // Suma de los resultados parciales
    always_comb begin
        product = {2*WIDTH{1'b0}}; // Inicializar a 0
        for (int i = 0; i < WIDTH; i = i + 1) begin
            product = product + partial_sum[i];
        end
        result = product[2*WIDTH-1:0];  // Tomar solo los bits necesarios
    end

endmodule
