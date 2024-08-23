module Register #(parameter N = 8) (
    input wire clk,
    input wire reset,
    input wire [N-1:0] D,
    output reg [N-1:0] Q
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            Q <= {N{1'b0}};  // Reset en todos los bits
        else
            Q <= D;
    end
endmodule
