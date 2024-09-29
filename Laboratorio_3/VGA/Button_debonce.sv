module Button_debounce (
    input logic button_in, clk_in,
    output logic button_stable
);
    logic enable_slow_clk;
    logic FF1, FF2, FF2_inv, FF0;

    // Generador de reloj más lento
    Slow_Clock_Enable slow_clk_gen (.clk_100MHz(clk_in), .enable_slow_clk(enable_slow_clk));

    // Flip-flops con habilitación de reloj
    D_FF_with_Enable dff_0 (.clk(clk_in), .clk_enable(enable_slow_clk), .D(button_in), .Q(FF0));
    D_FF_with_Enable dff_1 (.clk(clk_in), .clk_enable(enable_slow_clk), .D(FF0), .Q(FF1));
    D_FF_with_Enable dff_2 (.clk(clk_in), .clk_enable(enable_slow_clk), .D(FF1), .Q(FF2));

    // Inversión de la señal FF2 y generación de la salida debounced
    assign FF2_inv = ~FF2;
    assign button_stable = FF1 & FF2_inv;
endmodule

// Generador de reloj lento habilitado para la señal del botón
module Slow_Clock_Enable (
    input logic clk_100MHz,
    output logic enable_slow_clk
);
    logic [26:0] clk_counter = 0;

    // Contador para dividir la frecuencia del reloj y crear un enable de reloj lento
    always_ff @(posedge clk_100MHz) begin
        if (clk_counter >= 249999)
            clk_counter <= 0;
        else
            clk_counter <= clk_counter + 1;
    end

    assign enable_slow_clk = (clk_counter == 249999) ? 1'b1 : 1'b0;
endmodule

// D Flip-flop con habilitación de reloj para el proceso de debounce
module D_FF_with_Enable (
    input logic clk, clk_enable, D,
    output logic Q = 0
);
    // Captura el valor D solo cuando el habilitador de reloj está activo
    always_ff @(posedge clk) begin
        if (clk_enable)
            Q <= D;
    end
endmodule
