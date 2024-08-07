module bin_to_bcd #(parameter N = 6)(
    input logic [N-1:0] bin,
    output logic [3:0] bcd1, // Decenas (puede ser más de 4 bits si N > 8)
    output logic [3:0] bcd0  // Unidades
);
    logic [N-1:0] bcd_temp;
    integer i;

    always @(*) begin
        bcd_temp = bin;
        bcd1 = 4'd0;
        bcd0 = 4'd0;

        for (i = N-1; i >= 0; i = i - 1) begin
            // Incrementar los valores BCD si son mayores o iguales a 5
            if (bcd0 >= 4'd5) bcd0 = bcd0 + 4'd3;
            if (bcd1 >= 4'd5) bcd1 = bcd1 + 4'd3;

            // Desplazamiento a la izquierda
            bcd0 = {bcd0[2:0], bcd_temp[i]};
            bcd1 = {bcd1[2:0], 1'b0};
        end
    end
endmodule
