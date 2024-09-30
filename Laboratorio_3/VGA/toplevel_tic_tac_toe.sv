module toplevel_tic_tac_toe (
    input logic I, T, W, A, PLAYER_1, PLAYER_2, rst, clk, 
    output logic [3:0] estado, // Asumimos 4 bits para los estados
    output logic vgaclk, hsync, vsync, sync_b, blank_b, // Señales VGA
    output logic [7:0] r, g, b, // Señales de color VGA
    output logic [8:0] matrix_out_MEF,  // Salida de la matriz modificada
    output logic load,         // Señal de carga de la matriz
    output logic [6:0] segments,  // Segmentos del primer display de 7 segmentos
    output logic led_p1, led_p2  // LEDs para indicar turno de los jugadores
);

    logic [9:0] x, y;
    logic [7:0] r_PantallaInicial, g_PantallaInicial, b_PantallaInicial; // Señales para Pantalla Inicial
    logic [7:0] r_videoGen, g_videoGen, b_videoGen; // Señales para videoGen
    logic [7:0] r_black, g_black, b_black; // Señales para pantalla en negro
    logic finished;   // Señal que indica que el contador ha llegado a 15 segundos
    logic [3:0] count; // Temporizador de 4 bits
    logic reset_timer; // Control del temporizador
    logic reset_done;  // Señal de control del reset

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

    logic [8:0] matrix_in;
    logic [8:0] matrix_reg;    // Almacena la matriz de salida de matrixRegister
    
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

    // Definición de los estados
    typedef enum logic [3:0] {
        P_INICIO = 4'b0000,
        TABLERO = 4'b0001,
        TURNO_P1 = 4'b0010,   // Turno del jugador 1
        TURNO_P2 = 4'b0011,   // Turno del jugador 2
        CHECK_WIN = 4'b0100,  // Revisión del ganador
        GAME_OVER = 4'b0101   // Juego terminado
    } state_t;

    state_t current_state, next_state;

    // Actualización de estado y control del temporizador
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= P_INICIO;
            reset_timer <= 1'b1; // Resetear el temporizador al iniciar
            reset_done <= 1'b0;  // Asegurarse de que no se ha completado el reset
        end else begin
            current_state <= next_state;

            case (next_state)
                // Reseteamos el temporizador en TABLERO
                TABLERO: begin
                    reset_timer <= 1'b1;
                    reset_done <= 1'b0;
                end
                // En TURNO_P1 y TURNO_P2, el temporizador cuenta hasta F y cambia de turno
                TURNO_P1, TURNO_P2: begin
                    if (!reset_done) begin
                        reset_timer <= 1'b1;  // Reseteamos el temporizador al cambiar de turno
                        reset_done <= 1'b1;
                    end else begin
                        reset_timer <= 1'b0;  // Permitimos que el temporizador cuente
                    end
                end
                default: begin
                    reset_timer <= 1'b0;
                    reset_done <= 1'b0;
                end
            endcase
        end
    end

    // Lógica de transición de estados
    always_comb begin
        next_state = current_state;
        case (current_state)
            P_INICIO: begin
                if (T)
                    next_state = TABLERO;
                else
                    next_state = P_INICIO;
            end
            TABLERO: begin
                if (PLAYER_1)
                    next_state = TURNO_P1;
                else if (PLAYER_2)
                    next_state = TURNO_P2;
            end
            TURNO_P1: begin
                if (finished || count == 4'hF)  // Cambiar de turno si el temporizador llega a F
                    next_state = TURNO_P2;
                else if (A)
                    next_state = CHECK_WIN;
            end
            TURNO_P2: begin
                if (finished || count == 4'hF)  // Cambiar de turno si el temporizador llega a F
                    next_state = TURNO_P1;
                else if (A)
                    next_state = CHECK_WIN;
            end
            CHECK_WIN: begin
                if (A)
                    next_state = GAME_OVER;
                else
                    next_state = TABLERO;
            end
            GAME_OVER: begin
                if (A)
                    next_state = P_INICIO;
            end
            default: next_state = P_INICIO;
        endcase
    end

    // Lógica de salida (estado)
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            estado <= 4'b0000;
        else
            estado <= current_state;
    end
    
    // Control de los LEDs de los jugadores
	 always_ff @(posedge clk or posedge rst) begin
		 if (rst) begin
			 led_p1 <= 1'b1;  // Inicializamos los LEDs encendidos
			 led_p2 <= 1'b1;
		 end else begin
			 case (current_state)
					 TURNO_P1: begin
						 led_p1 <= 1'b1;   // Encendemos el LED del Jugador 1
						 led_p2 <= 1'b0;   // Apagamos el LED del Jugador 2
					 end
					 TURNO_P2: begin
						 led_p1 <= 1'b0;   // Apagamos el LED del Jugador 1
						 led_p2 <= 1'b1;   // Encendemos el LED del Jugador 2
					 end
					 default: begin
						 led_p1 <= 1'b0;   // Apagamos ambos LEDs en cualquier otro estado
						 led_p2 <= 1'b0;
					 end
			 endcase
		 end
	 end


    // Multiplexor para seleccionar qué imagen mostrar
    always_comb begin
        case (current_state)
            P_INICIO: begin
                r = r_PantallaInicial;
                g = g_PantallaInicial;
                b = b_PantallaInicial;
            end
            TABLERO, TURNO_P1, TURNO_P2, CHECK_WIN, GAME_OVER: begin
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
