module DecoderToBcd(in, out);

  input [3:0] in; //vector entrada
  
  output reg [7:0] out; //Vector salida
  
  always @(*) begin //esto indica que el bloque se ejecuta cada vez que la entrada cambia
  
    case (in) //selecciona un valor de salida según la entrada
	 
      4'b0000: out = 8'b00000000;
      4'b0001: out = 8'b00000001;
      4'b0010: out = 8'b00000010;
      4'b0011: out = 8'b00000011;
      4'b0100: out = 8'b00000100;
      4'b0101: out = 8'b00000101;
      4'b0110: out = 8'b00000110;
      4'b0111: out = 8'b00000111;
      4'b1000: out = 8'b00001000;
      4'b1001: out = 8'b00001001;
      4'b1010: out = 8'b00010000;
      4'b1011: out = 8'b00010001;
      4'b1100: out = 8'b00010010;
      4'b1101: out = 8'b00010011;
      4'b1110: out = 8'b00010100;
      4'b1111: out = 8'b00010101;
		
    endcase
	 
  end
  
endmodule

//Modelo de comportamiento porque describe como se debe comportar la decodificación de binario a BCD de una entrada de 
//4 bits a una salida de 8 usando un bloque always y una instrucción case, este enfoque se centra en como funciona
//el módulo sin especificar su implementación fisica detallada

//https://es.wikibooks.org/wiki/Programaci%C3%B3n_en_Verilog/M%C3%B3dulos