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
	 
	 initial begin
        reset = 1;
        a = 0;
        b = 0;

        // Aplicar reset asíncrono
        reset = 0;
        #10;
        reset = 1;

        // Casos de prueba
        a = 8'hFF; b = 8'h01; #10;
        $display("%0d - %0d = %0d (esperado: %0d)", a, b, y, a - b);

        a = 8'hA5; b = 8'h5A; #10;
        $display("%0d - %0d = %0d (esperado: %0d)", a, b, y, a - b);

        a = 8'h00; b = 8'h01; #10;
        $display("%0d - %0d = %0d (esperado: %0d)", a, b, y, a - b);

        $stop;
    end
endmodule
