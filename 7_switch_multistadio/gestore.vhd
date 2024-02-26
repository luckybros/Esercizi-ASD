library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity gestore is 
    port(
        en0, en1, en2, en3 : in STD_LOGIC;
        sel_sorgente: out STD_LOGIC_VECTOR(1 downto 0)
    );
    end entity;

architecture dataflow of gestore is
    begin 
    sel_sorgente <= "00" when en0 = '1' else
                    "01" when en1 = '1' else
                    "10" when en2 = '1' else
                    "11" when en3 = '1' else
                    "--";
end architecture;