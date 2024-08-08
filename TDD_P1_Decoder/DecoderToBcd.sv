module DecoderToBcd(
    input [3:0] in,  // vector entrada
    output reg [7:0] out  // Vector salida (8 bits BCD)
);

  always @(*) begin
    case (in)
      4'b0000: out = 8'b0000_0000; // 00
      4'b0001: out = 8'b0000_0001; // 01
      4'b0010: out = 8'b0000_0010; // 02
      4'b0011: out = 8'b0000_0011; // 03
      4'b0100: out = 8'b0000_0100; // 04
      4'b0101: out = 8'b0000_0101; // 05
      4'b0110: out = 8'b0000_0110; // 06
      4'b0111: out = 8'b0000_0111; // 07
      4'b1000: out = 8'b0000_1000; // 08
      4'b1001: out = 8'b0000_1001; // 09
      4'b1010: out = 8'b0001_0000; // 10
      4'b1011: out = 8'b0001_0001; // 11
      4'b1100: out = 8'b0001_0010; // 12
      4'b1101: out = 8'b0001_0011; // 13
      4'b1110: out = 8'b0001_0100; // 14
      4'b1111: out = 8'b0001_0101; // 15
      default: out = 8'b0000_0000; // Apagado para entradas no válidas
    endcase
  end
endmodule
