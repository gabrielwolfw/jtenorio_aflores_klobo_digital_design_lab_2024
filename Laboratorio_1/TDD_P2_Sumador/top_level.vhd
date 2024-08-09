library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity top_level is
    port (
        aVect : in std_logic_vector(3 downto 0);
        bVect : in std_logic_vector(3 downto 0);
        mainCarryIn : in std_logic;
        seg1 : out std_logic_vector(6 downto 0); -- Display de decenas
        seg2 : out std_logic_vector(6 downto 0)  -- Display de unidades
    );
end entity;

architecture Behavioral of top_level is
    signal sVect : std_logic_vector(3 downto 0);
    signal mainCarryOut : std_logic;
    signal decimalResult : integer range 0 to 30;
    signal bcd : std_logic_vector(7 downto 0);
    signal bcd_tens : std_logic_vector(3 downto 0);
    signal bcd_units : std_logic_vector(3 downto 0);
begin

    U1: entity work.sumador4bits
        port map (
            sVect => sVect,
            mainCarryOut => mainCarryOut,
            aVect => aVect,
            bVect => bVect,
            mainCarryIn => mainCarryIn,
            decimalResult => decimalResult
        );

    U2: entity work.bin_to_bcd
        port map (
            bin => sVect,
            bcd => bcd
        );

    bcd_tens <= bcd(7 downto 4);
    bcd_units <= bcd(3 downto 0);

    U3: entity work.bcd_to_7seg
        port map (
            bcd => bcd_tens,
            seg => seg1
        );

    U4: entity work.bcd_to_7seg
        port map (
            bcd => bcd_units,
            seg => seg2
        );
end architecture;
