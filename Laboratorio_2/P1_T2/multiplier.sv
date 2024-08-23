module multiplier (
    input logic [3:0] a, b,                  // Cambiado a 4 bits
    output logic [3:0] result                // Cambiado a 4 bits
);

    logic [7:0] product;
    logic [3:0] multiplicand;
    logic [3:0] multiplier;
    integer i;

    always_comb begin
        product = 8'b0;
        multiplicand = a;
        multiplier = b;

        for (i = 0; i < 4; i = i + 1) begin  // Cambiado a 4 iteraciones
            if (multiplier[i]) begin
                product = product + (multiplicand << i);
            end
        end

        result = product[3:0];              // Solo se toman los primeros 4 bits
    end

endmodule
