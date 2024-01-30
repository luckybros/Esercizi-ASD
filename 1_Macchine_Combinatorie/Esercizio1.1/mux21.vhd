library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux21 is 
    port(   a0  :   in STD_LOGIC;
            a1  :   in STD_LOGIC;
            s   :   in STD_LOGIC;
            y   :   out STD_LOGIC
    );
end mux21;

architecture dataflow of mux21 is
    begin
        y <= ((a0 AND (NOT s)) OR (a1 AND s));
end dataflow;
