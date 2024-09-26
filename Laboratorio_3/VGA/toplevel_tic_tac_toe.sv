module toplevel_tic_tac_toe (
    //input logic CLOCK_50,        // Reloj de la FPGA (50 MHz)
    input logic [1:0] SW,        // Switches para el modo de juego
    input logic [3:0] KEY,       // Botones (KEY[0]: Reset, KEY[1]: Jugada)
    output logic [9:0] LEDR,     // LEDs para visualizar el tablero y turno
    output logic [6:0] HEX0,     // 7 segmentos para el temporizador
    input logic clk_main, nxt,
    output logic vgaclk,         // 25.175 MHz VGA clock
    output logic hsync, vsync,
    output logic sync_b, blank_b, // To monitor 
    output logic [7:0] r, g, b    // Salidas RGB para el monitor
);

    // Señales internas
    logic [9:0] x, y;
    logic clk;
    logic reset;
    logic move_made;
    logic time_expired;
    logic victory;
    logic full_board;
    
    // Señales de salida de la FSM
    logic [2:0] state;
    logic player_turn;
    logic [8:0] board;
    logic game_over;
    logic random_move;
    
    // Señales internas para manejar RGB de las pantallas
    logic [7:0] r_start, g_start, b_start;  // Señales RGB para pantalla de inicio
    logic [7:0] r_game, g_game, b_game;     // Señales RGB para el juego
    
    // Modulo para obtener 25MHz
    pll vgapll(.inclk0(clk_main), .c0(vgaclk));
    
    // Generador de señales para el monitor
    vgaController vgaCont(vgaclk, hsync, vsync, sync_b, blank_b, x, y);

    // Instanciar la máquina de estados finita (FSM)
    tic_tac_toe_fsm fsm_inst (
        .clk(clk),
        .reset(reset),
        .mode(SW),
        .move_made(move_made),
        .time_expired(time_expired),
        .victory(victory),
        .full_board(full_board),
        .state(state),
        .player_turn(player_turn),
        .board(board),
        .game_over(game_over),
        .random_move(random_move)
    );
	 
    // Instanciar el módulo que genera los gráficos del juego
    videoGen videoGen_inst (
        .x(x), .y(y), 
        .r(r_game), .g(g_game), .b(b_game)
    );
    
    // Instanciar el módulo que genera la pantalla de inicio
    startScreen startScreen_inst (
        .x(x), .y(y), 
        .r(r_start), .g(g_start), .b(b_start)
    );

    // Condicional para alternar entre la pantalla de inicio y el juego según el estado
    always_comb begin
        if (state == 3'b000) begin  // Si el estado es START
            {r, g, b} = {r_start, g_start, b_start};  // Mostrar la pantalla de inicio
        end else begin  // Si el estado es distinto de START
            {r, g, b} = {r_game, g_game, b_game};    // Mostrar el tablero
        end
    end

    // Generar un reloj más lento a partir del reloj de 50 MHz
    reg [25:0] clk_div;
    always_ff @(posedge clk_main) begin
        clk_div <= clk_div + 1;
    end
    assign clk = clk_div[24];  // Reloj de aproximadamente 1 Hz (lento)

    // Mapeo de los botones
    assign reset = ~KEY[0];        // KEY[0] como señal de reset
    assign move_made = ~KEY[1];    // KEY[1] como señal de jugada

    // Visualización del tablero en los LEDs
    assign LEDR[8:0] = board;
    assign LEDR[9] = player_turn;  // Turno actual (Jugador 1: apagado, Jugador 2/PC: encendido)

    // Temporizador en HEX0 (simulación del temporizador de 15 segundos)
    reg [3:0] counter;
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            counter <= 4'd15;  // Reiniciar el contador a 15 segundos
        else if (move_made)
            counter <= 4'd15;  // Reiniciar cada vez que se hace una jugada
        else if (counter > 0)
            counter <= counter - 1;
    end

    // Decodificación del contador para mostrar en 7 segmentos
    always_comb begin
        case (counter)
            4'd0: HEX0 = 7'b1000000; // 0
            4'd1: HEX0 = 7'b1111001; // 1
            4'd2: HEX0 = 7'b0100100; // 2
            4'd3: HEX0 = 7'b0110000; // 3
            4'd4: HEX0 = 7'b0011001; // 4
            4'd5: HEX0 = 7'b0010010; // 5
            4'd6: HEX0 = 7'b0000010; // 6
            4'd7: HEX0 = 7'b1111000; // 7
            4'd8: HEX0 = 7'b0000000; // 8
            4'd9: HEX0 = 7'b0010000; // 9
            default: HEX0 = 7'b1111111; // Apagado
        endcase
    end

    // Simulación de las señales de victoria y empate (esto se cambiará con la lógica del juego)
    assign victory = (board[0] & board[1] & board[2]);  // Ganar en fila superior (Ejemplo)
    assign full_board = &board;  // Si todas las casillas están ocupadas

endmodule
