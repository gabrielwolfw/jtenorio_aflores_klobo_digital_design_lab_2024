module partial_multiplier #(
    parameter WIDTH = 4  // Tamaño del multiplicando y multiplicador
)(
    input logic [WIDTH-1:0] a,          // Multiplicando parametrizable
    input logic b,                      // Un solo bit del multiplicador
    input logic [WIDTH-1:0] shift,      // Cantidad de bits a desplazar
    output logic [2*WIDTH-1:0] result   // Resultado parcial de tamaño doble
);

    always_comb begin
        if (b) begin
            result = {WIDTH{1'b0}} << shift | a;  // Si b es 1, desplaza 'a' según sea necesario
        end else begin
            result = {2*WIDTH{1'b0}};            // Si b es 0, el resultado parcial es 0
        end
    end

endmodule

