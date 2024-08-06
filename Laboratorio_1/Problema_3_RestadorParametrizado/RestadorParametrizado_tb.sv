module RestadorParametrizado_tb;
    // Generador de reloj
    logic clk;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Señales para 6 bits
    logic [5:0] a6, b6;
    logic reset6;
    logic [5:0] y6;

    // Señales para 4 bits
    logic [3:0] a4, b4;
    logic reset4;
    logic [3:0] y4;

    // Señales para 2 bits
    logic [1:0] a2, b2;
    logic reset2;
    logic [1:0] y2;

    // Instanciación del módulo para 6 bits
    RestadorParametrizado #(6) uut6 (
        .a(a6),
        .b(b6),
        .reset(reset6),
        .clk(clk),
        .y(y6)
    );

    // Instanciación del módulo para 4 bits
    RestadorParametrizado #(4) uut4 (
        .a(a4),
        .b(b4),
        .reset(reset4),
        .clk(clk),
        .y(y4)
    );

    // Instanciación del módulo para 2 bits
    RestadorParametrizado #(2) uut2 (
        .a(a2),
        .b(b2),
        .reset(reset2),
        .clk(clk),
        .y(y2)
    );

    // Procedimiento de prueba para 6 bits
    initial begin
        reset6 = 1;
        a6 = 0;
        b6 = 0;
        #10 reset6 = 0; #10 reset6 = 1;

        a6 = 6'h3F; b6 = 6'h01; #10;
        $display("6 bits: %0d - %0d = %0d (esperado: %0d)", a6, b6, y6, a6 - b6);

        a6 = 6'h2A; b6 = 6'h15; #10;
        $display("6 bits: %0d - %0d = %0d (esperado: %0d)", a6, b6, y6, a6 - b6);

        a6 = 6'h00; b6 = 6'h01; #10;
        $display("6 bits: %0d - %0d = %0d (esperado: %0d)", a6, b6, y6, a6 - b6);
    end

    // Procedimiento de prueba para 4 bits
    initial begin
        reset4 = 1;
        a4 = 0;
        b4 = 0;
        #10 reset4 = 0; #10 reset4 = 1;

        a4 = 4'hF; b4 = 4'h1; #10;
        $display("4 bits: %0d - %0d = %0d (esperado: %0d)", a4, b4, y4, a4 - b4);

        a4 = 4'hA; b4 = 4'h5; #10;
        $display("4 bits: %0d - %0d = %0d (esperado: %0d)", a4, b4, y4, a4 - b4);

        a4 = 4'h0; b4 = 4'h1; #10;
        $display("4 bits: %0d - %0d = %0d (esperado: %0d)", a4, b4, y4, a4 - b4);
    end

    // Procedimiento de prueba para 2 bits
    initial begin
        reset2 = 1;
        a2 = 0;
        b2 = 0;
        #10 reset2 = 0; #10 reset2 = 1;

        a2 = 2'h3; b2 = 2'h1; #10;
        $display("2 bits: %0d - %0d = %0d (esperado: %0d)", a2, b2, y2, a2 - b2);

        a2 = 2'h2; b2 = 2'h1; #10;
        $display("2 bits: %0d - %0d = %0d (esperado: %0d)", a2, b2, y2, a2 - b2);

        a2 = 2'h0; b2 = 2'h1; #10;
        $display("2 bits: %0d - %0d = %0d (esperado: %0d)", a2, b2, y2, a2 - b2);

        $stop;
    end

endmodule
