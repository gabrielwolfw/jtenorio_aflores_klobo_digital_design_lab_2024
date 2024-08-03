module DecoderToBcd_tb();

  reg [3:0] in;
  
  wire [7:0] out;

  //instancia
  DecoderToBcd modulo (in, out);

  initial begin
    $monitor("in = %b, out = %b", in, out); //Sirve como si se pusieran displays en cada etapa, se declara en sentencias initial o always
	 
	 //se asignan los estímulos a la entrada
    in = 4'b0000; #40;
    in = 4'b0001; #40;
    in = 4'b0010; #40;
    in = 4'b0011; #40;
    in = 4'b0100; #40;
    in = 4'b0101; #40;
    in = 4'b0110; #40;
    in = 4'b0111; #40;
    in = 4'b1000; #40;
    in = 4'b1001; #40;
    in = 4'b1010; #40;
    in = 4'b1011; #40;
    in = 4'b1100; #40;
    in = 4'b1101; #40;
    in = 4'b1110; #40;
    in = 4'b1111; #40;
    $finish;
	 
  end
  
endmodule


