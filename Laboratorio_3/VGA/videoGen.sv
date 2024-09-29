module videoGen (
    input logic clk,           // Señal de reloj
    input logic rst_n,         // Señal de reinicio activo bajo
    input logic [9:0] x_pos, y_pos,  // Coordenadas de píxeles
    input logic [8:0] grid_state,    // Matriz de estado para las casillas
    output logic [7:0] red, green, blue // Salida de color RGB
);

    // Variables para las líneas del tablero
    logic vLine1, vLine2, hLine1, hLine2;
    logic [10:0] boxSize = 10'd40;
    logic [10:0] gap = 10'd10;
    logic [10:0] verticalOffset = 10'd150;  // Desplazamiento vertical
    logic [10:0] horizontalOffset = 10'd230; // Desplazamiento horizontal
    logic lines; // Variable combinada para las líneas

    // Variables para los círculos en las casillas
    logic [8:0] circleDraw;
    logic [10:0] radius = 10'd15; // Radio del círculo

    // Líneas del tablero de 3x3
    assign vLine1 = (x_pos >= horizontalOffset + boxSize + gap && x_pos <= horizontalOffset + boxSize + gap + 2 && 
                     y_pos >= verticalOffset && y_pos <= verticalOffset + 3 * boxSize + 2 * gap);
    assign vLine2 = (x_pos >= horizontalOffset + 2 * (boxSize + gap) && x_pos <= horizontalOffset + 2 * (boxSize + gap) + 2 && 
                     y_pos >= verticalOffset && y_pos <= verticalOffset + 3 * boxSize + 2 * gap);

    assign hLine1 = (y_pos >= verticalOffset + boxSize + gap && y_pos <= verticalOffset + boxSize + gap + 2 && 
                     x_pos >= horizontalOffset && x_pos <= horizontalOffset + 3 * boxSize + 2 * gap);
    assign hLine2 = (y_pos >= verticalOffset + 2 * (boxSize + gap) && y_pos <= verticalOffset + 2 * (boxSize + gap) + 2 && 
                     x_pos >= horizontalOffset && x_pos <= horizontalOffset + 3 * boxSize + 2 * gap);

    // Dibujar los círculos según el estado del tablero en la Matriz 3x3
    assign circleDraw[0] = (grid_state[0] == 1'b1) && 
                           ((x_pos - (horizontalOffset + boxSize / 2)) * (x_pos - (horizontalOffset + boxSize / 2)) + 
                           (y_pos - (verticalOffset + boxSize / 2)) * (y_pos - (verticalOffset + boxSize / 2)) <= radius * radius);
    assign circleDraw[1] = (grid_state[1] == 1'b1) && 
                           ((x_pos - (horizontalOffset + boxSize + gap + boxSize / 2)) * (x_pos - (horizontalOffset + boxSize + gap + boxSize / 2)) + 
                           (y_pos - (verticalOffset + boxSize / 2)) * (y_pos - (verticalOffset + boxSize / 2)) <= radius * radius);
    assign circleDraw[2] = (grid_state[2] == 1'b1) && 
                           ((x_pos - (horizontalOffset + 2 * (boxSize + gap) + boxSize / 2)) * (x_pos - (horizontalOffset + 2 * (boxSize + gap) + boxSize / 2)) + 
                           (y_pos - (verticalOffset + boxSize / 2)) * (y_pos - (verticalOffset + boxSize / 2)) <= radius * radius);

    assign circleDraw[3] = (grid_state[3] == 1'b1) && 
                           ((x_pos - (horizontalOffset + boxSize / 2)) * (x_pos - (horizontalOffset + boxSize / 2)) + 
                           (y_pos - (verticalOffset + boxSize + gap + boxSize / 2)) * (y_pos - (verticalOffset + boxSize + gap + boxSize / 2)) <= radius * radius);
    assign circleDraw[4] = (grid_state[4] == 1'b1) && 
                           ((x_pos - (horizontalOffset + boxSize + gap + boxSize / 2)) * (x_pos - (horizontalOffset + boxSize + gap + boxSize / 2)) + 
                           (y_pos - (verticalOffset + boxSize + gap + boxSize / 2)) * (y_pos - (verticalOffset + boxSize + gap + boxSize / 2)) <= radius * radius);
    assign circleDraw[5] = (grid_state[5] == 1'b1) && 
                           ((x_pos - (horizontalOffset + 2 * (boxSize + gap) + boxSize / 2)) * (x_pos - (horizontalOffset + 2 * (boxSize + gap) + boxSize / 2)) + 
                           (y_pos - (verticalOffset + boxSize + gap + boxSize / 2)) * (y_pos - (verticalOffset + boxSize + gap + boxSize / 2)) <= radius * radius);

    assign circleDraw[6] = (grid_state[6] == 1'b1) && 
                           ((x_pos - (horizontalOffset + boxSize / 2)) * (x_pos - (horizontalOffset + boxSize / 2)) + 
                           (y_pos - (verticalOffset + 2 * (boxSize + gap) + boxSize / 2)) * (y_pos - (verticalOffset + 2 * (boxSize + gap) + boxSize / 2)) <= radius * radius);
    assign circleDraw[7] = (grid_state[7] == 1'b1) && 
                           ((x_pos - (horizontalOffset + boxSize + gap + boxSize / 2)) * (x_pos - (horizontalOffset + boxSize + gap + boxSize / 2)) + 
                           (y_pos - (verticalOffset + 2 * (boxSize + gap) + boxSize / 2)) * (y_pos - (verticalOffset + 2 * (boxSize + gap) + boxSize / 2)) <= radius * radius);
    assign circleDraw[8] = (grid_state[8] == 1'b1) && 
                           ((x_pos - (horizontalOffset + 2 * (boxSize + gap) + boxSize / 2)) * (x_pos - (horizontalOffset + 2 * (boxSize + gap) + boxSize / 2)) + 
                           (y_pos - (verticalOffset + 2 * (boxSize + gap) + boxSize / 2)) * (y_pos - (verticalOffset + 2 * (boxSize + gap) + boxSize / 2)) <= radius * radius);

    // Combinamos todas las líneas y círculos para determinar el color de los píxeles
    assign lines = vLine1 | vLine2 | hLine1 | hLine2;
    assign red = (|circleDraw) ? 8'hFF : 8'h00;  // Rojo si hay un círculo
    assign green = 8'h00;
    assign blue = (lines) ? 8'hFF : 8'h00;    // Líneas del tablero en azul

endmodule
