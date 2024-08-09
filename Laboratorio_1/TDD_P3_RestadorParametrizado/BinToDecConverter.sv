module BinToDecConverter #(parameter N = 6)(
    input logic [N-1:0] bin, // Número binario de entrada
    output logic [3:0] tens, // Dígito de las decenas
    output logic [3:0] units // Dígito de las unidades
);
    integer i;
    logic [31:0] result;

    always_comb begin
        result = 0;
        for (i = 0; i < N; i = i + 1) begin
            if (bin[i]) begin
                result = result + (1 << i);
            end
        end

        // Dividir el resultado en dígitos decimales
        tens = result / 10;
        units = result % 10;
    end
endmodule
