module videoGen (
    input logic clk,           // Señal de reloj
    input logic rst_n,         // Señal de reset activo bajo
    input logic [9:0] x, y,    // Coordenadas de píxeles
    input logic [8:0] matrix,  // Matriz que representa el estado de las casillas
    output logic [7:0] r, g, b // Salida RGB
);

    // Parámetros constantes
    localparam squareSize = 10'd40;
    localparam spacing = 10'd10;
    localparam topOffset = 10'd150;
    localparam leftOffset = 10'd230;

    // Variable para combinar líneas del tablero
    logic line;

    // Líneas del tablero combinadas en una sola expresión
    always_comb begin
        // Líneas verticales
        line = ((x >= leftOffset + squareSize + spacing && x <= leftOffset + squareSize + spacing + 2) ||
                (x >= leftOffset + 2 * (squareSize + spacing) && x <= leftOffset + 2 * (squareSize + spacing) + 2)) && 
                (y >= topOffset && y <= topOffset + 3 * squareSize + 2 * spacing) ||
               // Líneas horizontales
               ((y >= topOffset + squareSize + spacing && y <= topOffset + squareSize + spacing + 2) ||
                (y >= topOffset + 2 * (squareSize + spacing) && y <= topOffset + 2 * (squareSize + spacing) + 2)) && 
                (x >= leftOffset && x <= leftOffset + 3 * squareSize + 2 * spacing);
    end

    // Dibujar las X en las casillas según el estado de la matriz
    logic drawX;
    always_comb begin
        drawX = 0;
        for (int i = 0; i < 9; i++) begin
            if (matrix[i] == 1'b1) begin
                int row = i / 3;
                int col = i % 3;
                if (x >= leftOffset + col * (squareSize + spacing) && 
                    x < leftOffset + (col + 1) * squareSize + col * spacing &&
                    y >= topOffset + row * (squareSize + spacing) && 
                    y < topOffset + (row + 1) * squareSize + row * spacing) begin
                    drawX = 1;
                end
            end
        end
    end

    // Salida RGB: Rojo para las X y Azul para las líneas
    always_comb begin
        r = (drawX) ? 8'hFF : 8'h00;
        g = 8'h00;
        b = (line) ? 8'hFF : 8'h00;
    end

endmodule

