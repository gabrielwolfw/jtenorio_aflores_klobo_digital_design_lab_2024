module TopLevel_tb();

  reg [3:0] in;
  wire [7:0] bcd;
  wire [6:0] seg1;
  wire [6:0] seg0;

  // Instancia del módulo top-level
  TopLevel uut (
    .in(in),
    .seg1(seg1),
    .seg0(seg0)
  );

  // onecta la señal out de DecoderToBcd a la señal bcd en el testbench.
  assign bcd = uut.decoder.out;

  // Monitorear todas las señales
  initial begin
    $monitor("time = %0d, in = %b, bcd = %b, seg1 = %b, seg0 = %b", $time, in, bcd, seg1, seg0);
  end

  // estímulos
  initial begin
    in = 4'b0000; 
	 #40;
    in = 4'b0001; 
	 #40;
    in = 4'b0010; 
	 #40;
    in = 4'b0011; 
	 #40;
    in = 4'b0100; 
	 #40;
    in = 4'b0101; 
	 #40;
    in = 4'b0110; 
	 #40;
    in = 4'b0111; 
	 #40;
    in = 4'b1000; 
	 #40;
    in = 4'b1001; 
	 #40;
    in = 4'b1010; 
	 #40;
    in = 4'b1011; 
	 #40;
    in = 4'b1100; 
	 #40;
    in = 4'b1101; 
	 #40;
    in = 4'b1110; 
	 #40;
    in = 4'b1111; 
	 #40;
    $finish;
  end
endmodule

