library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux12 is 
    port(   demux_12_in  : in STD_LOGIC;
            demux_12_sel   : in STD_LOGIC;
            demux_12_out0  : out STD_LOGIC;
            demux_12_out1  : out STD_LOGIC
    );
end demux12;

architecture dataflow of demux12 is
begin
    demux_12_out0 <= ((NOT demux_12_sel) AND demux_12_in);
    demux_12_out1 <= (demux_12_sel AND demux_12_in);
end dataflow;
