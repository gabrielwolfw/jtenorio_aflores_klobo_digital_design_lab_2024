module full_adder #(
    parameter WIDTH = 1  // Tamaño del bit, por defecto es 1 bit
)(
    input logic [WIDTH-1:0] a,  // Entrada A
    input logic [WIDTH-1:0] b,  // Entrada B
    input logic [WIDTH-1:0] cin, // Entrada de acarreo
    output logic [WIDTH-1:0] sum, // Salida de suma
    output logic [WIDTH-1:0] cout // Salida de acarreo
);

    // Comportamiento del full adder para un ancho de palabra
    assign sum = a ^ b ^ cin;                // Suma (bit de menor peso)
    assign cout = (a & b) | (cin & (a ^ b)); // Acarreo

endmodule

