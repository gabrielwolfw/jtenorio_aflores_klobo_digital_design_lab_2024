module ALU #(parameter N = 4)(
	input logic [N-1:0] A,B,
	input logic [2:0] ALU_Sel, \\Selector de operaciones
	output logic[N-1:0]ALU_Out,
	output logic CarryOut,Zero,Overflow
);

	logic [N:0] temp;
	
	always_comb begin
		case (ALU_Sel)
		3'b000: begin //suma
			temp = A + B;
			ALU_Out = temp[N-1:0];
			CarryOut = temp[N];
		end
		3'b001: begin //resta
			temp = A - B;
			ALU_Out = temp[N-1:0];
			CarryOut = temp[N];
		end
	end
endmodule
