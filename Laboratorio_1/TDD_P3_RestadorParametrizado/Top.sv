module Top(
    input wire clk,
    input wire reset_sw,
    input wire dec_btn,
    output wire [6:0] seg1,  // Display 7 segmentos para las decenas
    output wire [6:0] seg0   // Display 7 segmentos para las unidades
);
    // Valores iniciales para el restador
    reg [5:0] initial_value = 6'b111111; // Se pueden usar otros valores iniciales

    // Instancia del restador parametrizado
    RestadorParametrizado #(6) restador (
        .clk(clk),
        .reset(reset_sw),
        .initial_value(initial_value),
        .dec(dec_btn),
        .seg1(seg1),
        .seg0(seg0)
    );

endmodule
