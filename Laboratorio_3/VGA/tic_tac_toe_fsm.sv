module tic_tac_toe_fsm (
    input logic clk,             // Reloj
    input logic reset,           // Señal de reset
    input logic [1:0] mode,      // Selección de modo: 00 -> Jug vs Jug, 01 -> Jug vs PC
    input logic move_made,       // Señal que indica que se realizó una jugada
    input logic time_expired,    // Señal de tiempo expirado (15 segundos)
    input logic victory,         // Señal de victoria
    input logic full_board,      // Señal de tablero lleno (empate)
    output logic [2:0] state,    // Estado actual (solo para depuración)
    output logic player_turn,    // 0 -> Jugador 1, 1 -> Jugador 2 o PC
    output logic [8:0] board,    // Estado del tablero de juego
    output logic game_over,      // Indica si el juego terminó
    output logic random_move     // Indica si se debe hacer un movimiento aleatorio
);

    // Definir los estados
    typedef enum logic [2:0] {
        START      = 3'b000,  // Pantalla inicial
        PLAYER1    = 3'b001,  // Turno Jugador 1
        PLAYER2    = 3'b010,  // Turno Jugador 2 o PC
        CHECK_WIN  = 3'b011,  // Verificar victoria o empate
        GAME_OVER  = 3'b100   // Fin del juego
    } state_t;
    
    state_t current_state, next_state;

    // Variables para manejar el turno del jugador y el tablero
    logic [8:0] board_reg;
    logic player_turn_reg;
    logic random_move_reg;
    logic game_over_reg;

    // Asignaciones de salida
    assign state = current_state;
    assign player_turn = player_turn_reg;
    assign board = board_reg;
    assign game_over = game_over_reg;
    assign random_move = random_move_reg;

    // Máquina de estados secuencial
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= START;
            board_reg <= 9'b0;          // Reiniciar tablero
            player_turn_reg <= 1'b0;    // Empieza el Jugador 1
            game_over_reg <= 1'b0;
        end else begin
            current_state <= next_state;
            // Actualizamos player_turn y game_over en función del estado
            if (current_state == CHECK_WIN) begin
                if (!victory && !full_board) begin
                    player_turn_reg <= ~player_turn_reg; // Cambia el turno
                end
            end
            if (current_state == GAME_OVER) begin
                game_over_reg <= 1'b1;
            end
        end
    end

    // Lógica de transición de estados combinacional
    always_comb begin
        // Estado por defecto
        next_state = current_state;
        random_move_reg = 1'b0;

        case (current_state)
            START: begin
                // Pantalla inicial, seleccionamos modo de juego
                if (mode != 2'b00) begin
                    next_state = PLAYER1;
                end
            end
            
            PLAYER1: begin
                // Turno del Jugador 1
                if (move_made) begin
                    next_state = CHECK_WIN;
                end else if (time_expired) begin
                    random_move_reg = 1'b1;  // Se hace un movimiento aleatorio si el tiempo expiró
                    next_state = CHECK_WIN;
                end
            end
            
            PLAYER2: begin
                // Turno del Jugador 2 o PC
                if (move_made || time_expired) begin
                    if (time_expired) random_move_reg = 1'b1; // Movimiento aleatorio
                    next_state = CHECK_WIN;
                end
            end
            
            CHECK_WIN: begin
                // Verificamos si hay un ganador o empate
                if (victory || full_board) begin
                    next_state = GAME_OVER;
                end else begin
                    next_state = player_turn_reg ? PLAYER2 : PLAYER1;
                end
            end

            GAME_OVER: begin
                // El juego terminó, esperamos a un reset
            end
            
            default: next_state = START;
        endcase
    end
endmodule