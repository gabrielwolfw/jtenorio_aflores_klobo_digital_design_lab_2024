module toplevel_tic_tac_toe (
    input logic I, T, W, A, PLAYER_1, PLAYER_2, NEXT, TEST, rst, clk, 
    output logic [3:0] estado, // Asumimos 4 bits para los estados
    output logic vgaclk, hsync, vsync, sync_b, blank_b, // Señales VGA
    output logic [7:0] r, g, b, // Señales de color VGA
    output logic [8:0] matrix_out_MEF,  // Salida de la matriz modificada
    output logic load,         // Señal de carga de la matriz
    output logic [6:0] segments,  // Segmentos del primer display de 7 segmentos
    output logic led_p1, led_p2,  // LEDs para indicar turno de los jugadores
	 output logic reset_timer,
	 output logic reset_done
);

    logic [9:0] x, y;
    logic [7:0] r_PantallaInicial, g_PantallaInicial, b_PantallaInicial; // Señales para Pantalla Inicial
    logic [7:0] r_videoGen, g_videoGen, b_videoGen; // Señales para videoGen
    logic [7:0] r_black, g_black, b_black; // Señales para pantalla en negro
    logic finished;   // Señal que indica que el contador ha llegado a 15 segundos
	 logic [8:0] matrix_in;
    logic [8:0] matrix_reg; 
    logic [3:0] count; // Temporizador de 4 bits

    // Instancia de PLL para generar la señal de 25.175 MHz para el VGA
    pll vgapll(.inclk0(clk), .c0(vgaclk));

    // Instancia del controlador VGA
    vgaController vgaCont(.vgaclk(vgaclk), .hsync(hsync), .vsync(vsync), .sync_b(sync_b), .blank_b(blank_b), .x(x), .y(y));

    // Instancia del módulo Pantalla_Inicial
    startScreen pantallaInicial(
        .x(x), 
        .y(y), 
        .r(r_PantallaInicial), 
        .g(g_PantallaInicial), 
        .b(b_PantallaInicial)
    );
	 
	 // Instancia de la MEF
    tic_tac_toe_fsm mef (
        .I(I), .T(T), .W(W), .A(A), .PLAYER_1(PLAYER_1), .PLAYER_2(PLAYER_2),
        .NEXT(NEXT), .TEST(TEST), .rst(rst), .clk(clk),
        .estado(estado), .reset_timer(reset_timer), .reset_done(reset_done),
        .led_p1(led_p1), .led_p2(led_p2)
    );
    
    // Instancia del Temporizador
    Full_Timer timer_inst (
        .clk_in(clk),
        .rst_in(reset_timer),
        .done(finished),
        .count_out(count)
    );
    
    BCD_Visualizer segBCD_inst (
        .bin(count),
        .seg(segments)
    );
    
    // Instancia del módulo videoGen
    videoGen vgagen(
        .x_pos(x), 
        .y_pos(y), 
        .grid_state(matrix_out_MEF),
        .red(r_videoGen), 
        .green(g_videoGen), 
        .blue(b_videoGen)
    );
    
    initial begin
        matrix_reg = 9'b10;  // Inicializar la matriz
    end
    
    logic rst_n;
    assign rst_n = !rst;

    // Instancia del módulo debounce_better_version
    Button_debounce debounce_I (
        .button_in(I),
        .clk_in(clk),
        .button_stable(Idebounced)
    );
    
    Button_debounce debounce_W (
        .button_in(W),
        .clk_in(clk),
        .button_stable(Wdebounced)
    );

    // Instancia del módulo matrixControl
    matrixTableroControl u_matrixControl (
        .clk(clk),
        .rst_n(rst_n),
        .I(I),
        .W(!Wdebounced),
        .matrix_in(matrix_reg),
        .matrix_out(matrix_in),
        .load(load)
    );

    // Instancia del módulo matrixRegister
    matrixTablero u_matrixRegister (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(matrix_in),
        .load(load),
        .matrix(matrix_reg)
    );
    
    assign matrix_out_MEF = matrix_reg;

    // Pantalla en negro (todos los píxeles son 0)
    assign r_black = 8'b00000000;
    assign g_black = 8'b00000000;
    assign b_black = 8'b00000000;

    // Multiplexor para seleccionar qué imagen mostrar
    always_comb begin
        case (estado)
            4'b0000: begin
                r = r_PantallaInicial;
                g = g_PantallaInicial;
                b = b_PantallaInicial;
            end
            4'b0001, 4'b0010, 4'b0011, 4'b0100, 4'b0101: begin
                r = r_videoGen;
                g = g_videoGen;
                b = b_videoGen;
            end
            default: begin
                r = r_black;
                g = g_black;
                b = b_black;
            end
        endcase
    end
endmodule
