library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity bin_to_bcd is
    port (
        bin : in std_logic_vector(3 downto 0);
        bcd : out std_logic_vector(7 downto 0) -- BCD tiene 2 dígitos: decenas y unidades
    );
end entity;

architecture Behavioral of bin_to_bcd is
begin
    process(bin)
        variable temp : std_logic_vector(7 downto 0);
    begin
        temp := (others => '0');
        temp(3 downto 0) := bin;

        for i in 0 to 3 loop
            if unsigned(temp(7 downto 4)) >= 5 then
                temp(7 downto 4) := std_logic_vector(unsigned(temp(7 downto 4)) + 3);
            end if;
            if unsigned(temp(3 downto 0)) >= 5 then
                temp(3 downto 0) := std_logic_vector(unsigned(temp(3 downto 0)) + 3);
            end if;
            temp := temp(6 downto 0) & '0';
        end loop;
        
        bcd <= temp;
    end process;
end architecture;
