library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux14 is 
    port(   demux_14_in  : in STD_LOGIC;
            demux_14_sel : in STD_LOGIC_VECTOR(1 downto 0);
            demux_14_out : out STD_LOGIC_VECTOR(3 downto 0)
    );
end demux14;

architecture structural of demux14 is
    signal u : STD_LOGIC_VECTOR(1 downto 0);
    
    component demux12 is 
        port(   demux_12_in  : in STD_LOGIC;
                demux_12_sel  : in STD_LOGIC;
                demux_12_out : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

begin 
    mux0: demux12
        port map( demux_12_in => demux_14_in,
                  demux_12_sel => demux_14_sel(1),
                  demux_12_out => u
        );
    mux1: demux12
        port map( demux_12_in => u(0),
                  demux_12_sel => demux_14_sel(0),
                  demux_12_out => demux_14_out(1 downto 0)
        );
    mux2: demux12
        port map( demux_12_in => u(1),
                  demux_12_sel => demux_14_sel(0),
                  demux_12_out => demux_14_out(3 downto 2)
        );
end structural;