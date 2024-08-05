module RestadorParametrizado_tb;
    parameter N = 8;  // Parámetro del tamaño de los bits

    logic [N-1:0] a, b;  // Entradas del restador
    logic reset;         // Señal de reset asíncrono
    logic clk;           // Señal de reloj
    logic [N-1:0] y;     // Salida del restador

    RestadorParametrizado #(N) uut (
        .a(a),
        .b(b),
        .reset(reset),
        .clk(clk),
        .y(y)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;  // Generador de reloj
    end
endmodule
