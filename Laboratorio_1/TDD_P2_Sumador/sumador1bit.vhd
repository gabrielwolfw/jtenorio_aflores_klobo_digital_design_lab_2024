-- Sumador completo de 1 bit
library IEEE;
use IEEE.std_logic_1164.all;

entity sumador1bit is
    port (
        sum, carryOut : out std_logic;
        a, b, carryIn : in std_logic
    );
end entity;

architecture arch of sumador1bit is
begin

    sum <= ((not carryIn) and (not a) and b)
        or ((not carryIn) and a and (not b))
        or (carryIn and (not a) and (not b))
        or (carryIn and a and b);

    carryOut <= (carryIn and b) or (a and b) or (carryIn and a);

end architecture;