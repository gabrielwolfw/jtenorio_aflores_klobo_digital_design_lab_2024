module full_adder (
    input logic a, b, cin,
    output logic sum, cout
);

    assign sum = a ^ b ^ cin; 					// Suma (bit de menor peso)
    assign cout = (a & b) | (cin & (a ^ b)); // Acarreo

endmodule
