module RestadorParametrizado_tb();

    // Señales de prueba
    logic clk;
    logic reset;
    logic [5:0] initial_value;
    logic dec;
    
    // Salidas para displays de 7 segmentos
    logic [6:0] seg1_2bits, seg0_2bits;
    logic [6:0] seg1_4bits, seg0_4bits;
    logic [6:0] seg1_6bits, seg0_6bits;

    // Salidas del contador para las pruebas
    logic [1:0] count2;
    logic [3:0] count4;
    logic [5:0] count6;

    // Instancias del módulo RestadorParametrizado
    RestadorParametrizado #(2) uut2 (
        .clk(clk),
        .reset(reset),
        .initial_value(initial_value[1:0]),
        .dec(dec),
        .seg1(seg1_2bits),
        .seg0(seg0_2bits),
        .count(count2) // Conectar el puerto count
    );

    RestadorParametrizado #(4) uut4 (
        .clk(clk),
        .reset(reset),
        .initial_value(initial_value[3:0]),
        .dec(dec),
        .seg1(seg1_4bits),
        .seg0(seg0_4bits),
        .count(count4) // Conectar el puerto count
    );

    RestadorParametrizado #(6) uut6 (
        .clk(clk),
        .reset(reset),
        .initial_value(initial_value),
        .dec(dec),
        .seg1(seg1_6bits),
        .seg0(seg0_6bits),
        .count(count6) // Conectar el puerto count
    );

    // Generación del reloj
    always #5 clk = ~clk;

    // Tarea para mostrar resultados de los displays de 7 segmentos
    task display_7seg;
        input [6:0] seg;
        begin
            $write("7-segment: ");
            case (seg)
                7'b1000000: $write("0");
                7'b1111001: $write("1");
                7'b0100100: $write("2");
                7'b0110000: $write("3");
                7'b0011001: $write("4");
                7'b0010010: $write("5");
                7'b0000010: $write("6");
                7'b1111000: $write("7");
                7'b0000000: $write("8");
                7'b0010000: $write("9");
                default:    $write("X"); // Unknown/error
            endcase
            $write("\n");
        end
    endtask

    initial begin
        // Inicialización de señales
        clk = 0;
        reset = 0;
        dec = 1;

        // Prueba para 2 bits
        initial_value = 6'b000010; // Valor 2 para 2 bits
        $display("=== Iniciando prueba para 2 bits ===");
        #10 reset = 1;
        #10 reset = 0;
        #10 dec = 0;
        #30 dec = 1; // Decrementar después de 30 unidades de tiempo
        #10 $display("Valor final del contador para 2 bits: %b", count2);
        $write("Decenas: ");
        display_7seg(seg1_2bits);
        $write("Unidades: ");
        display_7seg(seg0_2bits);

        // Prueba para 4 bits
        initial_value = 6'b000101; // Valor 5 para 4 bits
        $display("=== Iniciando prueba para 4 bits ===");
        #10 reset = 1;
        #10 reset = 0;
        #10 dec = 0;
        #30 dec = 1; // Decrementar después de 30 unidades de tiempo
        #10 $display("Valor final del contador para 4 bits: %b", count4);
        $write("Decenas: ");
        display_7seg(seg1_4bits);
        $write("Unidades: ");
        display_7seg(seg0_4bits);

        // Prueba para 6 bits
        initial_value = 6'b001110; // Valor 14 para 6 bits
        $display("=== Iniciando prueba para 6 bits ===");
        #10 reset = 1;
        #10 reset = 0;
        #10 dec = 0;
        #30 dec = 1; // Decrementar después de 30 unidades de tiempo
        #10 $display("Valor final del contador para 6 bits: %b", count6);
        $write("Decenas: ");
        display_7seg(seg1_6bits);
        $write("Unidades: ");
        display_7seg(seg0_6bits);

        // Fin de la simulación
        $stop;
    end
endmodule
