library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux14 is 
    port(   demux_14_in  : in STD_LOGIC;
            demux_14_sel1 : in STD_LOGIC;
            demux_14_sel2 : in STD_LOGIC;
            demux_14_out0 : out STD_LOGIC;
            demux_14_out1 : out STD_LOGIC;
            demux_14_out2 : out STD_LOGIC;
            demux_14_out3 : out STD_LOGIC
    );
end demux14;

architecture structural of demux14 is
    signal u : STD_LOGIC_VECTOR(1 downto 0);
    
    component demux12 is 
        port(   demux_12_in  : in STD_LOGIC;
                demux_12_sel  : in STD_LOGIC;
                demux_12_out0 : out STD_LOGIC;
                demux_12_out1 : out STD_LOGIC
        );
    end component;

begin 
    mux0: demux12
        port map( demux_12_in => demux_14_in,
                  demux_12_sel => demux_14_sel1,
                  demux_12_out0 => u(0),
                  demux_12_out1 => u(1)
        );
    mux1: demux12
        port map( demux_12_in => u(0),
                  demux_12_sel => demux_14_sel2,
                  demux_12_out0 => demux_14_out0,
                  demux_12_out1 => demux_14_out1
        );
    mux2: demux12
        port map( demux_12_in => u(1),
                  demux_12_sel => demux_14_sel2,
                  demux_12_out0 => demux_14_out2,
                  demux_12_out1 => demux_14_out3
        );
end structural;