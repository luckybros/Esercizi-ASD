library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux12 is 
    port(   demux_12_in  : in STD_LOGIC;
            demux_12_sel   : in STD_LOGIC;
            demux_12_out  : out STD_LOGIC_VECTOR(1 downto 0)
    );
end demux12;

architecture dataflow of demux12 is
begin
    demux_12_out(0) <= ((NOT demux_12_sel) AND demux_12_in);
    demux_12_out(1) <= (demux_12_sel AND demux_12_in);
end dataflow;
