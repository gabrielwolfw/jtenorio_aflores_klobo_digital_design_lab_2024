module CircuitoMedicion #(parameter N = 8)(
	input wire clk,			//Señal de reloj	
	input wire reset,			//Señal de reset
	input wire [N-1:0] in, 	//Entrada de datos
	output wire [N-1:0] out //Salida de datos
);
	wire [N-1:0] reg1_out; //Se 
	wire [N-1:] alu_out;   //Salida de ALU
	
	//Registro de entrada
	Register #(N) reg1(
		.clk(clk),
		.reset(reset),
		.D(in),
		.Q(reg1_out)
	);
	
	ALU #(N) alu1(
		.a(reg1_out),
		.b(in_b),
		.operation(operation)
	);
	
	
	
	// Registro de salida
   Register #(N) reg2 (
        .clk(clk),
        .reset(reset),
        .D(alu_out),
        .Q(out)
    );
	
endmodule