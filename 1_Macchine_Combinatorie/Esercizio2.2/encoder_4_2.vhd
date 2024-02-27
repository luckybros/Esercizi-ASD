library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoder42 is
    port(   a : in STD_LOGIC_VECTOR (3 downto 0);
            y : out STD_LOGIC_VECTOR (1 downto 0)
    );
end encoder42;

architecture dataflow of encoder42 is

    begin
        y       <=  "00" when a="0001" else
                    "01" when a="0010" else
                    "10" when a="0100" else
                    "11" when a="1000" else
                    "--";

end dataflow;
