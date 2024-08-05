module RestadorParametrizado_tb;
    
    // Procedimiento de test
    task run_test(input int N);
        logic [N-1:0] a, b;
        logic reset;
        logic clk;
        logic [N-1:0] y;

        RestadorParametrizado #(N) uut (
            .a(a),
            .b(b),
            .reset(reset),
            .clk(clk),
            .y(y)
        );

        initial begin
            clk = 0;
            forever #5 clk = ~clk;
        end

        initial begin
            reset = 1;
            a = 0;
            b = 0;

            // Aplicar reset asíncrono
            reset = 0;
            #10;
            reset = 1;

            // Casos de prueba
            a = 'hFF >> (8-N); b = 1; #10;
            $display("N=%0d: %0d - %0d = %0d (esperado: %0d)", N, a, b, y, a - b);

            a = 'hA5 >> (8-N); b = 'h5A >> (8-N); #10;
            $display("N=%0d: %0d - %0d = %0d (esperado: %0d)", N, a, b, y, a - b);

            a = 0; b = 1; #10;
            $display("N=%0d: %0d - %0d = %0d (esperado: %0d)", N, a, b, y, a - b);

            $stop;
        end
    endtask

    initial begin
        run_test(6);
        run_test(4);
        run_test(2);
    end

endmodule

