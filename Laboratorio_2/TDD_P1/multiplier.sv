module multiplier #(
    parameter WIDTH = 4  // Parametro para definir el ancho de los buses
)(
    input logic [WIDTH-1:0] a, b,              // Entradas parametrizadas
    output logic [WIDTH-1:0] result            // Resultado parametrizado
);

    logic [(2*WIDTH)-1:0] partial_sum[WIDTH-1:0]; // Sumas parciales parametrizadas
    logic [(2*WIDTH)-1:0] product;               // Producto final parametrizado

    // Instancias de partial_multiplier parametrizadas
    genvar i;
    generate
        for (i = 0; i < WIDTH; i = i + 1) begin : partial_multipliers
            partial_multiplier #(.WIDTH(WIDTH)) pm (
                .a(a),
                .b(b[i]),
                .shift(i),
                .result(partial_sum[i])
            );
        end
    endgenerate

    // Suma de los resultados parciales
    always_comb begin
        product = '0;  // Inicializar el producto
        for (int j = 0; j < WIDTH; j = j + 1) begin
            product = product + partial_sum[j];
        end
        result = product[WIDTH-1:0];  // Tomar solo los primeros WIDTH bits
    end

endmodule
