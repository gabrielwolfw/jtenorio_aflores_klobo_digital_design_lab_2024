module Testbench();
    reg clk;
    reg reset;
    reg [7:0] in_a;
    reg [7:0] in_b;
    reg [3:0] operation;
    wire [7:0] out;
    wire outFlagC;
    wire outFlagN;
    wire outFlagV;
    wire outFlagZ;
    wire [6:0] segA;

    // Instancia del circuito con 8 bits
    CircuitoMedicion #(8) uut (
        .clk(clk),
        .reset(reset),
        .in_a(in_a),
        .in_b(in_b),
        .operation(operation),
        .out(out),
        .outFlagC(outFlagC),
        .outFlagN(outFlagN),
        .outFlagV(outFlagV),
        .outFlagZ(outFlagZ),
        .segA(segA)
    );

    // Generación de reloj
    initial begin
        clk = 0;
        forever #10 clk = ~clk; // 50 MHz
    end

    // Proceso de prueba
    initial begin
        // Inicialización
        reset = 1;
        in_a = 8'h00;
        in_b = 8'h00;
        operation = 4'b0000;
        
        // Aplicar reset
        #20 reset = 0;
        
        // Caso 1: Suma
        in_a = 8'h1A;
        in_b = 8'h2B;
        operation = 4'b0000; // Asumamos que 4'b0000 es la operación de suma
        #20;
        $display("Case 1: in_a = %h, in_b = %h, operation = %b, out = %h", in_a, in_b, operation, out);
        
        // Caso 2: Resta
        in_a = 8'h3C;
        in_b = 8'h1F;
        operation = 4'b0001; // Asumamos que 4'b0001 es la operación de resta
        #20;
        $display("Case 2: in_a = %h, in_b = %h, operation = %b, out = %h", in_a, in_b, operation, out);
        
        // Caso 3: AND
        in_a = 8'hFF;
        in_b = 8'h0F;
        operation = 4'b0010; // Asumamos que 4'b0010 es la operación AND
        #20;
        $display("Case 3: in_a = %h, in_b = %h, operation = %b, out = %h", in_a, in_b, operation, out);
        
        // Caso 4: OR
        in_a = 8'hAA;
        in_b = 8'h55;
        operation = 4'b0011; // Asumamos que 4'b0011 es la operación OR
        #20;
        $display("Case 4: in_a = %h, in_b = %h, operation = %b, out = %h", in_a, in_b, operation, out);
        
        // Detener simulación
        #20;
        $stop;
    end
endmodule
