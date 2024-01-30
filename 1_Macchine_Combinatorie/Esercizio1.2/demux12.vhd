library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux12 is 
    port(   a  : in STD_LOGIC;
            s   : in STD_LOGIC;
            y0  : out STD_LOGIC;
            y1  : out STD_LOGIC
    );
end demux12;

architecture dataflow of demux12 is
begin
    y0 <= ((NOT s) AND a);
    y1 <= (s AND a);
end dataflow;
