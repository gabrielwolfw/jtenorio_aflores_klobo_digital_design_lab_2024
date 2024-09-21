`timescale 1ns/1ps

module tb_tic_tac_toe_fsm;
    // Señales de entrada
    logic clk;
    logic reset;
    logic [1:0] mode;
    logic move_made;
    logic time_expired;
    logic victory;
    logic full_board;
    
    // Señales de salida
    logic [2:0] state;
    logic player_turn;
    logic [8:0] board;
    logic game_over;
    logic random_move;

    // Instanciar el módulo bajo prueba (DUT - Device Under Test)
    tic_tac_toe_fsm dut (
        .clk(clk),
        .reset(reset),
        .mode(mode),
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

    // Reloj de 10ns
    always #5 clk = ~clk;

    initial begin
        // Inicializar señales
        clk = 0;
        reset = 1;
        mode = 2'b00;
        move_made = 0;
        time_expired = 0;
        victory = 0;
        full_board = 0;

        // Soltar reset después de 20 ns
        #20 reset = 0;

        // Selección del modo de juego (Jugador 1 vs Jugador 2)
        #10 mode = 2'b01;  // Cambia el modo a Jugador 1 vs PC

        // Simular turno del Jugador 1
        #30 move_made = 1;  // Jugador 1 hace una jugada
        #10 move_made = 0;

        // Simular turno del Jugador 2 / PC
        #30 time_expired = 1;  // Tiempo del Jugador 2 se agota
        #10 time_expired = 0;

        // Simular verificación de victoria
        #40 victory = 1;  // Se detecta una victoria
        #20 victory = 0;

        // Fin del juego
        #40 reset = 1;  // Resetear el juego

        #50 $stop;  // Terminar la simulación
    end
endmodule
