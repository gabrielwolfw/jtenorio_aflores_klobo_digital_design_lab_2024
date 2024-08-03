-- Testbench para el sumador de 4 bits --
library IEEE;
use IEEE.std_logic_1164.all;

entity sumador4bits_tb is
end entity;

architecture arch of sumador4bits_tb is

    component sumador4bits is
        port (
            sVect : out std_logic_vector (3 downto 0);
            mainCarryOut : out std_logic;
            aVect : in std_logic_vector (3 downto 0);
            bVect : in std_logic_vector (3 downto 0);
            mainCarryIn : in std_logic
        );
    end component;

    signal testFourBitsA, testFourBitsB, testFourBitsSum : std_logic_vector (3 downto 0);
    signal testCarryIn, testCarryOut : std_logic;

begin

    unit_under_test : sumador4bits port map (
        sVect => testFourBitsSum,
        mainCarryOut => testCarryOut,

        aVect => testFourBitsA,
        bVect => testFourBitsB,
        mainCarryIn => testCarryIn
    );

    generate_signals : process
    begin
        --testCarryIn <= '0'; testFourBitsA <= "0000"; testFourBitsB <= "0001"; wait for 10 ns;
        testCarryIn <= '0'; testFourBitsA <= "0001"; testFourBitsB <= "0001"; wait for 10 ns;
        --testCarryIn <= '0'; testFourBitsA <= "0010"; testFourBitsB <= "0001"; wait for 10 ns;
        --testCarryIn <= '0'; testFourBitsA <= "0011"; testFourBitsB <= "0001"; wait for 10 ns;
        --testCarryIn <= '0'; testFourBitsA <= "0100"; testFourBitsB <= "0001"; wait for 10 ns;
        --testCarryIn <= '0'; testFourBitsA <= "0101"; testFourBitsB <= "0001"; wait for 10 ns;
        --testCarryIn <= '0'; testFourBitsA <= "0110"; testFourBitsB <= "0001"; wait for 10 ns;
        --testCarryIn <= '0'; testFourBitsA <= "0111"; testFourBitsB <= "0001"; wait for 10 ns;
        --testCarryIn <= '0'; testFourBitsA <= "1000"; testFourBitsB <= "0001"; wait for 10 ns;
        --testCarryIn <= '0'; testFourBitsA <= "1001"; testFourBitsB <= "0001"; wait for 10 ns;
        --testCarryIn <= '0'; testFourBitsA <= "1010"; testFourBitsB <= "0001"; wait for 10 ns;
        --testCarryIn <= '0'; testFourBitsA <= "1011"; testFourBitsB <= "0001"; wait for 10 ns;
        --testCarryIn <= '0'; testFourBitsA <= "1100"; testFourBitsB <= "0001"; wait for 10 ns;
        --testCarryIn <= '0'; testFourBitsA <= "1101"; testFourBitsB <= "0001"; wait for 10 ns;
        --testCarryIn <= '0'; testFourBitsA <= "1110"; testFourBitsB <= "0001"; wait for 10 ns;
        --testCarryIn <= '0'; testFourBitsA <= "1111"; testFourBitsB <= "0001"; wait for 10 ns;
        wait;
    end process;

end architecture;
