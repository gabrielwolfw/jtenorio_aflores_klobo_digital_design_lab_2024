module toplevel_tic_tac_toe ( input logic I,  T, W,  A, rst, clk, 
    output logic [3:0] estado, // Asumimos 4 bits para los estados
    output logic vgaclk, hsync, vsync, sync_b, blank_b, // Señales VGA
    output logic [7:0] r, g, b, // Señales de color VGA
	 output logic [8:0] matrix_out_MEF,  // Salida de la matriz modificada
	 output logic load,         // Señal de carga de la matriz
	 //output logic finished,    // Señal que indica que el contador ha llegado a 15 segundos
    output logic [6:0] segments  // Segmentos del primer display de 7 segmentos (decenas)
    //output logic [6:0] seg2   // Segmentos del segundo display de 7 segmentos (unidades)
);

    //logic C;
    logic [9:0] x, y;
    logic [7:0] r_PantallaInicial, g_PantallaInicial, b_PantallaInicial; // Señales para Pantalla Inicial
    logic [7:0] r_videoGen, g_videoGen, b_videoGen; // Señales para videoGen
    logic [7:0] r_black, g_black, b_black; // Señales para pantalla en negro
	 logic finished;   // Señal que indica que el contador ha llegado a 15 segundos
	 logic [3:0] count;
	
	 
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
	 
	 // Instancia del Tiempo
	 
	  Full_Timer timer_inst (
        .clk_in(clk),
        .rst_in(rst),
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
        matrix_reg = 9'b10;  // Inicializar la matriz con ceros
    end
	 //assign matrix_out_MEF = 9'b0;
	 
	 
	 logic rst_n;
	 assign rst_n = !rst;
	 
	 
	 
	 
    // Instancia del módulo debounce_better_version
    Button_debounce (
        .button_in(I),       // Entrada del botón con rebote
        .clk_in(clk),           // Reloj principal del sistema
        .button_stable(Idebounced)   // Señal de salida debounced
    );
	  Button_debounce (
        .button_in(W),       // Entrada del botón con rebote
        .clk_in(clk),           // Reloj principal del sistema
        .button_stable(Wdebounced)   // Señal de salida debounced
    );

    // Instancia del módulo matrixControl
    matrixTableroControl u_matrixControl (
        .clk(clk),              // Señal de reloj
        .rst_n(rst_n),          // Señal de reset activo bajo
        .I(I),                  // Botón para seleccionar la posición de la matriz
        .W(!Wdebounced),                  // Botón para confirmar y modificar la posición seleccionada
        .matrix_in(matrix_reg),   // Matriz de entrada (inicial)
        .matrix_out(matrix_in), // Matriz de salida con el valor modificado
        .load(load)             // Señal que indica que se realizó un cambio
    );
	 
	 // Instancia del módulo matrixRegister
    matrixTablero u_matrixRegister (
        .clk(clk),              // Señal de reloj
        .rst_n(rst_n),          // Señal de reset activo bajo
        .data_in(matrix_in),    // Datos modificados que se cargarán en el registro
        .load(load),            // Señal de carga desde matrixControl
        .matrix(matrix_reg)     // Matriz de salida del registro
    );
	 
	 assign matrix_out_MEF = matrix_reg;

    // Pantalla en negro (todos los píxeles son 0)
    assign r_black = 8'b00000000;
    assign g_black = 8'b00000000;
    assign b_black = 8'b00000000;

    // Definir los estados de la MEF
    typedef enum logic [3:0] {
        P_INICIO = 4'b0000, TABLERO = 4'b0001
		  //, S2 = 4'b0010, S3 = 4'b0011,
//        S4 = 4'b0100, S5 = 4'b0101, S6 = 4'b0110, S7 = 4'b0111, 
//        S8 = 4'b1000, S9 = 4'b1001
    } state_t;

    state_t current_state, next_state;


    // Actualización de estado
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= P_INICIO;
        else
            current_state <= next_state;
    end

    // Lógica de transición de estados
    always_comb begin
        next_state = current_state;
        case (current_state)
            P_INICIO: begin
                if (T) 
                    next_state = TABLERO; 
//                else if (A)
//                    next_state = S5;
					 else next_state= P_INICIO;
            end
            TABLERO: begin
//                if (G)
//                    next_state = S3;
//                else if (P)
//                    next_state = S4;
                 if (A)
							next_state=P_INICIO;
                    //next_state = S2;
//                else if (L)
//                    next_state = S0;
					 else next_state= TABLERO;
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

    // Multiplexor para seleccionar qué imagen mostrar
    always_comb begin
        case (current_state)
            // En el estado P_INICIO mostramos la imagen generada por Pantalla_Inicial
            P_INICIO: begin
                r = r_PantallaInicial;
                g = g_PantallaInicial;
                b = b_PantallaInicial;
            end
            // En el estado TABLERO mostramos la imagen generada por videoGen
            TABLERO: begin
                r = r_videoGen;
                g = g_videoGen;
                b = b_videoGen;
            end
            // Al cambiar de estado, poner la pantalla en negro para "borrar"
            default: begin
                r = r_black;
                g = g_black;
                b = b_black;
            end
        endcase
    end
endmodule
