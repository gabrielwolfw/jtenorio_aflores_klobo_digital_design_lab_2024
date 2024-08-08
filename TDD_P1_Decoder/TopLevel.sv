module TopLevel(
    input [3:0] in,  // vector entrada
    output [6:0] seg1,  // Vector de 7 segmentos para el dígito más significativo
    output [6:0] seg0   // Vector de 7 segmentos para el dígito menos significativo
);

  wire [7:0] bcd;  // Vector BCD de 8 bits

  // Instancia del módulo DecoderToBcd
  DecoderToBcd decoder (
    .in(in),
    .out(bcd)
  );

  // Instancia del módulo BcdTo7Segment para el dígito menos significativo
  BcdTo7Segment display0 (
    .bcd(bcd[3:0]),
    .seg(seg0)
  );

  // Instancia del módulo BcdTo7Segment para el dígito más significativo
  BcdTo7Segment display1 (
    .bcd(bcd[7:4]),
    .seg(seg1)
  );

endmodule
