module partial_multiplier (
    input logic [3:0] a,          // Multiplicando de 4 bits
    input logic b,                // Un solo bit del multiplicador
    input logic [1:0] shift,      // Cantidad de bits a desplazar
    output logic [7:0] result     // Resultado parcial de 8 bits
);

    always_comb begin
        if (b) begin
            result = {4'b0, a} << shift;  // Si b es 1, desplaza 'a' segun sea necesario
        end else begin
            result = 8'b0;                // Si b es 0, el resultado parcial es 0
        end
    end

endmodule
