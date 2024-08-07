module RestadorParametrizado_tb();
    logic clk;
    logic reset;
    logic dec;
    logic [1:0] count2;
    logic [3:0] count4;
    logic [5:0] count6;
    logic [5:0] initial_value;

    // Instancias del restador parametrizable para 2, 4 y 6 bits
    RestadorParametrizado #(2) uut2 (
        .clk(clk),
        .reset(reset),
        .initial_value(initial_value[1:0]),
        .dec(dec),
        .count(count2)
    );

    RestadorParametrizado #(4) uut4 (
        .clk(clk),
        .reset(reset),
        .initial_value(initial_value[3:0]),
        .dec(dec),
        .count(count4)
    );

    RestadorParametrizado #(6) uut6 (
        .clk(clk),
        .reset(reset),
        .initial_value(initial_value),
        .dec(dec),
        .count(count6)
    );

    // Generación del clock
    always #5 clk = ~clk;

    initial begin
        // Inicialización de señales
        clk = 0;
        reset = 0;
        dec = 0;

        // Prueba para 2 bits
        initial_value = 6'b000010; // Solo los 2 bits menos significativos se usan
        $display("=== Iniciando prueba para 2 bits ===");
        #10 reset = 1;
        #10 reset = 0;
        #10 dec = 1;
        #50 dec = 0;
        #10 $display("Valor final del contador para 2 bits: %b", count2);

        // Prueba para 4 bits
        initial_value = 6'b001010; // Solo los 4 bits menos significativos se usan
        $display("=== Iniciando prueba para 4 bits ===");
        #10 reset = 1;
        #10 reset = 0;
        #10 dec = 1;
        #50 dec = 0;
        #10 $display("Valor final del contador para 4 bits: %b", count4);

        // Prueba para 6 bits
        initial_value = 6'b101010; // Se usan los 6 bits
        $display("=== Iniciando prueba para 6 bits ===");
        #10 reset = 1;
        #10 reset = 0;
        #10 dec = 1;
        #50 dec = 0;
        #10 $display("Valor final del contador para 6 bits: %b", count6);

        // Fin de la simulación
        $stop;
    end
endmodule
