module RestadorParametrizado #(parameter int N = 8)
(
    input logic [N-1:0] a,   // Entrada A
    input logic [N-1:0] b,   // Entrada B
    input logic reset,       // Señal de reset asíncrono
    input logic clk,         // Señal de reloj
    output logic [N-1:0] y   // Salida del resultado de la resta
);
	 // Registro para almacenar el resultado
    logic [N-1:0] result;

    always_ff @(posedge clk or negedge reset) begin
        if (!reset) begin
            result <= '0;
        end else begin
            result <= a - b;
        end
    end

    // La salida del módulo es el resultado registrado
    assign y = result;

endmodule
