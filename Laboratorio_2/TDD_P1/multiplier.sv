module multiplier (
    input logic [3:0] a, b,                  // Entradas de 4 bits
    output logic [3:0] result                // Resultado de 4 bits
);

    logic [3:0] partial_sum[3:0];            // Almacena las sumas parciales en cada paso
    logic [7:0] product;                     // Producto total inicializado a 0

    // Generar las sumas parciales
    always_comb begin
        partial_sum[0] = b[0] ? a : 4'b0;
        partial_sum[1] = b[1] ? (a << 1) : 4'b0;
        partial_sum[2] = b[2] ? (a << 2) : 4'b0;
        partial_sum[3] = b[3] ? (a << 3) : 4'b0;

        // Sumar las sumas parciales
        product = {4'b0, partial_sum[0]} + {4'b0, partial_sum[1]} + {4'b0, partial_sum[2]} + {4'b0, partial_sum[3]};
        
        // Tomar solo los primeros 4 bits del producto
        result = product[3:0];
		  
    end

endmodule
