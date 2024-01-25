library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoder_4_2 is
    port(   x : in STD_LOGIC_VECTOR (3 downto 0);
            y : out STD_LOGIC_VECTOR (1 downto 0)
    );
end encoder_4_2;

architecture dataflow of encoder_4_2 is
    begin
        y <= "00" when x = "0001" else
             "01" when x="0010" else
             "10" when x="0100" else
             "11" when x="1000" else
             "--";
end dataflow;