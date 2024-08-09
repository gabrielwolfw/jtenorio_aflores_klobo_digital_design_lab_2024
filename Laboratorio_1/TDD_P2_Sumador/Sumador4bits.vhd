-- Sumador de 4 bits --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; --funciones de numeric_std

entity sumador4bits is
    port (
        sVect : out std_logic_vector (3 downto 0);
        mainCarryOut : out std_logic;
        aVect : in std_logic_vector (3 downto 0);
        bVect : in std_logic_vector (3 downto 0);
        mainCarryIn : in std_logic;
        decimalResult : out integer range 0 to 30 --salida decimal
    );
end entity;

architecture arch_sumador4bits of sumador4bits is

    component sumador1bit is
        port (
            sum, carryOut : out std_logic;
            a, b, carryIn : in std_logic
        );
    end component;

    signal auxCarry : std_logic_vector (4 downto 0);
    signal internalSum : std_logic_vector (3 downto 0); -- Señal interna para almacenar el resultado (decimal)

begin

    auxCarry(0) <= mainCarryIn;

    bit_s0: sumador1bit port map (
        sum => internalSum(0), --InternalSum puede cambiarse a sVect si no se necesita decimal
        carryOut => auxCarry(1),
        a => aVect(0),
        b => bVect(0),
        carryIn => auxCarry(0)
    );

    bit_s1: sumador1bit port map (
        sum => internalSum(1),
        carryOut => auxCarry(2),
        a => aVect(1),
        b => bVect(1),
        carryIn => auxCarry(1)
    );

    bit_s2: sumador1bit port map (
        sum => internalSum(2),
        carryOut => auxCarry(3),
        a => aVect(2),
        b => bVect(2),
        carryIn => auxCarry(2)
    );

    bit_s3: sumador1bit port map (
        sum => internalSum(3),
        carryOut => auxCarry(4),
        a => aVect(3),
        b => bVect(3),
        carryIn => auxCarry(3)
    );

    mainCarryOut <= auxCarry(4);

    -- Asignar el resultado a la salida sVect
    sVect <= internalSum;

    -- Convertir el resultado binario a decimal
    decimalResult <= to_integer(unsigned(internalSum));

end architecture;
