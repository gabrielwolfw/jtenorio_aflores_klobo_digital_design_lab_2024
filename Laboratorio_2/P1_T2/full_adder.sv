module full_adder (
    input logic a, b, cin,
    output logic sum, cout
);

    assign {cout, sum} = a + b + cin;

endmodule
