module toplevel_tic_tac_toe ( input logic I,  T, W,  A, rst, clk,
 
    output logic [3:0] estado, // Asumimos 4 bits para los estados
    output logic vgaclk, hsync, vsync, sync_b, blank_b, // Señales VGA
    output logic [7:0] r, g, b, // Señales de color VGA
	 output logic [8:0] matrix_out_MEF,  // Salida de la matriz modificada
	 output logic load,         // Señal de carga de la matriz
	 output logic W_deb, I_deb
);



    //logic C;
    logic [9:0] x, y;
    logic [7:0] r_PantallaInicial, g_PantallaInicial, b_PantallaInicial; // Señales para Pantalla Inicial
    logic [7:0] r_videoGen, g_videoGen, b_videoGen; // Señales para videoGen
    logic [7:0] r_black, g_black, b_black; // Señales para pantalla en negro

	
	 
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

    // Instancia del módulo videoGen
    videoGen vgagen(
        .x(x), 
        .y(y), 
		  .matrix(matrix_out_MEF),
        .r(r_videoGen), 
        .g(g_videoGen), 
        .b(b_videoGen)
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
        .pb_1(I),       // Entrada del botón con rebote
        .clk(clk),           // Reloj principal del sistema
        .pb_out(Idebounced)   // Señal de salida debounced
    );
	  Button_debounce (
        .pb_1(W),       // Entrada del botón con rebote
        .clk(clk),           // Reloj principal del sistema
        .pb_out(Wdebounced)   // Señal de salida debounced
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
        S0 = 4'b0000, S1 = 4'b0001
		  //, S2 = 4'b0010, S3 = 4'b0011,
//        S4 = 4'b0100, S5 = 4'b0101, S6 = 4'b0110, S7 = 4'b0111, 
//        S8 = 4'b1000, S9 = 4'b1001
    } state_t;

    state_t current_state, next_state;


//    always_comb begin
//        C = ~(G ^ P); // XNOR entre G y P
//    end

    // Actualización de estado
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Lógica de transición de estados
    always_comb begin
        next_state = current_state; // Mantener el estado por defecto
        case (current_state)
            S0: begin
                if (T) // Verificar que T está en alto
                    next_state = S1; // Cambio a S1 si T está en alto
//                else if (A)
//                    next_state = S5;
					 else next_state= S0;
            end
            S1: begin
//                if (G)
//                    next_state = S3;
//                else if (P)
//                    next_state = S4;
                 if (A)
							next_state=S0;
                    //next_state = S2;
//                else if (L)
//                    next_state = S0;
					 else next_state= S1;
            end
//            S2: begin
//                if (G)
//                    next_state = S3;
//                else if (P)
//                    next_state = S4;
//                else if (C)
//                    next_state = S1;
//                else if (L)
//                    next_state = S0;
//					 else next_state= S2;
//            end
//            S3:  next_state = S0; 
//			
//            S4:  next_state = S0; 
//            S5: begin
//                if (I)
//                    next_state = S6;
//                else if (A)
//                    next_state = S7;
//					 else next_state= S5;
//            end
//            S6: begin
//                if (I)
//                    next_state = S7;
//                else if (P)
//                    next_state = S8;
//                else if (G)
//                    next_state = S9;
//                else if (L)
//                    next_state = S6;
//					 else;
//            end
//            S7: begin
//                if (A)
//                    next_state = S5;
//                else if (P)
//                    next_state = S8;
//                else if (G)
//                    next_state = S9;
//                else if (L)
//                    next_state = S0;
//					 else next_state= S7;
//            end
//            S8: next_state = S0; 
//            S9: next_state = S0;
            default: next_state = S0;
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
            // En el estado S0 mostramos la imagen generada por Pantalla_Inicial
            S0: begin
                r = r_PantallaInicial;
                g = g_PantallaInicial;
                b = b_PantallaInicial;
            end
            // En el estado S1 mostramos la imagen generada por videoGen
            S1: begin
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
