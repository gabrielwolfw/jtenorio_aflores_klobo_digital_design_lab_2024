module partial_multiplier #(
    parameter WIDTH = 4  // Parametro para definir el ancho de los buses
)(
    input logic [WIDTH-1:0] a,                // Multiplicando parametrizado
    input logic b,                            // Un solo bit del multiplicador
    input logic [$clog2(WIDTH)-1:0] shift,    // Cantidad de bits a desplazar, ajustada
    output logic [(2*WIDTH)-1:0] result       // Resultado parcial parametrizado
);

    always_comb begin
        if (b) begin
            result = {{WIDTH{1'b0}}, a} << shift;  // Si b es 1, desplaza 'a' según sea necesario
        end else begin
            result = '0;                          // Si b es 0, el resultado parcial es 0
        end
    end

endmodule
