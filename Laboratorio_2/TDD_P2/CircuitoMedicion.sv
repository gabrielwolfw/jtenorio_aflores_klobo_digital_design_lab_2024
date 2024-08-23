module CircuitoMedicion #(parameter N = 8)(
	input wire clk,			//Señal de reloj	
	input wire reset,			//Señal de reset
	input wire [N-1:0] in, 	//Entrada de datos
	output wire [N-1:0] out //Salida de datos
);
	wire [N-1:0] reg1_out; //Se debe crear un modulo de registro
	wire [N-1:] alu_out;   //Añadir la ALU
	
	
endmodule