-- Testbench para el sumador de 4 bits --
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sumador4bits_tb is
end entity;

architecture arch of sumador4bits_tb is

    component sumador4bits is
        port (
            sVect : out std_logic_vector (3 downto 0);
            mainCarryOut : out std_logic;
            aVect : in std_logic_vector (3 downto 0);
            bVect : in std_logic_vector (3 downto 0);
            mainCarryIn : in std_logic;
            decimalResult : out integer range 0 to 30
        );
    end component;

    signal testFourBitsA, testFourBitsB, testFourBitsSum : std_logic_vector (3 downto 0);
    signal testCarryIn, testCarryOut : std_logic;
    signal testDecimalResult : integer range 0 to 30;

begin

    unit_under_test : sumador4bits port map (
        sVect => testFourBitsSum,
        mainCarryOut => testCarryOut,
        aVect => testFourBitsA,
        bVect => testFourBitsB,
        mainCarryIn => testCarryIn,
        decimalResult => testDecimalResult
    );

    generate_signals : process
    begin
	 
		  -- Report para hacer "prints" en consola con el resultado en decimal
        -- TEST 1
        testCarryIn <= '0'; testFourBitsA <= "0001"; testFourBitsB <= "0001"; wait for 10 ns;
        report "Resultado para 0001 + 0001: " & integer'image(testDecimalResult); 

        -- TEST 2
        testCarryIn <= '0'; testFourBitsA <= "0100"; testFourBitsB <= "0101"; wait for 10 ns;
        report "Resultado para 0100 + 0101: " & integer'image(testDecimalResult); 

        -- TEST 3
        testCarryIn <= '0'; testFourBitsA <= "0111"; testFourBitsB <= "0111"; wait for 10 ns;
        report "Resultado para 0111 + 0111: " & integer'image(testDecimalResult); 

        -- TEST 4 (con acarreo)
        testCarryIn <= '1'; testFourBitsA <= "0001"; testFourBitsB <= "0110"; wait for 10 ns;
        report "Resultado para 0001 + 0110 con acarreo 1: " & integer'image(testDecimalResult); 

        wait;
    end process;

end architecture;
