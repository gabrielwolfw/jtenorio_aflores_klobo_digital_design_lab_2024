module RestadorParametrizado #(parameter N = 6)(
    input logic clk,
    input logic reset,
    input logic [N-1:0] initial_value,
    input logic dec,
    output logic [N-1:0] count
);
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            count <= initial_value;
        else if (dec)
            count <= count - 1;
    end
endmodule
