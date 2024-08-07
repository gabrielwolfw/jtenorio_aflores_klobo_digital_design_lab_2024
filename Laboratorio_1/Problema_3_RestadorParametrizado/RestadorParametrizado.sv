module RestadorParametrizado #(parameter N = 6)(
    input logic clk,
    input logic reset,
    input logic [N-1:0] initial_value,
    input logic dec,
    output logic [6:0] seg1,  // Display 7 segmentos para las decenas
    output logic [6:0] seg0   // Display 7 segmentos para las unidades
);
    logic [N-1:0] count;
    logic [3:0] bcd1, bcd0;

    // Instancia del restador
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            count <= initial_value;
        else if (dec)
            count <= count - 1;
    end

    // Conversión de binario a BCD
    bin_to_bcd bin_to_bcd_inst (
        .bin(count),
        .bcd1(bcd1),
        .bcd0(bcd0)
    );

    // Conversión de BCD a 7 segmentos
    bcd_to_7seg bcd_to_7seg_inst0 (
        .bcd(bcd0),
        .seg(seg0)
    );

    bcd_to_7seg bcd_to_7seg_inst1 (
        .bcd(bcd1),
        .seg(seg1)
    );
endmodule

