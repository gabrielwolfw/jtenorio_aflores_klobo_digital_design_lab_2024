module DecoderToBcd(
    input [3:0] in,  // vector entrada
    output reg [7:0] out  // Vector salida (8 bits BCD)
);

  always @(*) begin
    case (in)
      4'b0000: out = 8'b0000_0000; // 00
      4'b0001: out = 8'b0000_0001; // .
      4'b0010: out = 8'b0000_0010; // .
      4'b0011: out = 8'b0000_0011; // .
      4'b0100: out = 8'b0000_0100; // .
      4'b0101: out = 8'b0000_0101; // .
      4'b0110: out = 8'b0000_0110; // .
      4'b0111: out = 8'b0000_0111; // .
      4'b1000: out = 8'b0000_1000; // .
      4'b1001: out = 8'b0000_1001; // .
      4'b1010: out = 8'b0001_0000; // .
      4'b1011: out = 8'b0001_0001; // .
      4'b1100: out = 8'b0001_0010; // .
      4'b1101: out = 8'b0001_0011; // .
      4'b1110: out = 8'b0001_0100; // .
      4'b1111: out = 8'b0001_0101; // .
      default: out = 8'b0000_0000; // Apagado para entradas no válidas
    endcase
  end
endmodule

//El código emplea el modelo de comportamiento mediante el always, cambiando instantaneamente
//cada salida según la entrada, se describe en alto nivel cómo se debe decodificar
//sin específicar sus componentes físicos necesarios
