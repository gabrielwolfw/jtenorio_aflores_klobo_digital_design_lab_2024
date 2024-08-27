module full_adder #(
    parameter WIDTH = 1  // Parametro para definir el ancho de los bits
)(
    input logic [WIDTH-1:0] a, b, cin,      // Ancho de bits parametrizado
    output logic [WIDTH-1:0] sum, cout      // Ancho de bits parametrizado
);

    assign sum = a ^ b ^ cin;               // Suma (bit de menor peso)
    assign cout = (a & b) | (cin & (a ^ b));// Acarreo

endmodule
