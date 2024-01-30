library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux14 is 
    port(   b   : in STD_LOGIC;
            s1  : in STD_LOGIC;
            s2  : in STD_LOGIC;
            y0  : out STD_LOGIC;
            y1  : out STD_LOGIC;
            y2  : out STD_LOGIC;
            y3  : out STD_LOGIC
    );
end demux14;

architecture structural of demux14 is
    signal u : STD_LOGIC_VECTOR(1 downto 0);
    
    component demux12 is 
    port(   a  : in STD_LOGIC;
            s  : in STD_LOGIC;
            w0 : out STD_LOGIC;
            w1 : out STD_LOGIC
    );
    end component;

begin 
    mux0: demux12
        port map( a => b,
                  s => s1,
                  w0 => u(0),
                  w1 => u(1)
        );
    mux1: demux12
        port map( a => u(0),
                  s => s2,
                  w0 => y0,
                  w1 => y1
        );
    mux2: demux12
        port map( a => u(1),
                  s => s2,
                  w0 => y2,
                  w1 => y3
        );
end structural;

