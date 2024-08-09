module RestadorParametrizado #(parameter int N = 8)
(
	input logic [N-1:0] a, b, 
	input logic clk,
	input logic asyn_reset,
	output logic [N-1:0] z 
);

always_ff @(posedge clk or posedge async_reset) begin
    if (async_reset) begin
        z <= '0; //Se añade los ceros
    end else begin
        z <= a - b; //Se aplica la resta
    end
end
endmodule
