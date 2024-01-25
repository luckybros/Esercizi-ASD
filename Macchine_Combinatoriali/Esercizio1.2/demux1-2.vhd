library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity demux1-2 is 
    port(   a  :   in STD_LOGIC;
            s   :   in STD_LOGIC;
            y0  :   out STD_LOGIC;
            y1  :   out STD_LOGIC;
    );
end demux1-2;

architecture dataflow of demux1-2 is
    begin
        y0 <= (a AND (NOT s));
        y1 <= (a AND s);
    end dataflow;