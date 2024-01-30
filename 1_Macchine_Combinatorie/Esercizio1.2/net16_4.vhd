library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity net16_4 is
    port(   a : in STD_LOGIC_VECTOR(15 downto 0);
            s_mux : in STD_LOGIC_VECTOR(3 downto 0);
            s_demux : in STD_LOGIC_VECTOR(1 downto 0);
            y : out STD_LOGIC_VECTOR(3 downto 0)
    );
end net16_4;

architecture structural of net16_4 is
    signal u : STD_LOGIC;

    component mux161 is 
    port(  c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, 
           c14, c15, s0, s1, s2, s3 : in STD_LOGIC;
           y0 : out STD_LOGIC
    );
    end component;

    component demux14 is 
    port(   c : in STD_LOGIC;
            s1 : in STD_LOGIC;
            s2 : in STD_LOGIC;
            y0 : out STD_LOGIC;
            y1 : out STD_LOGIC;
            y2 : out STD_LOGIC;
            y3 : out STD_LOGIC
    );
    end component;

begin 
    mux: mux161
        port map(   c0 => a(0),
                    c1 => a(1),
                    c2 => a(2),
                    c3 => a(3),
                    c4 => a(4),
                    c5 => a(5),
                    c6 => a(6),
                    c7 => a(7),
                    c8 => a(8),
                    c9 => a(9),
                    c10 => a(10),
                    c11 => a(11),
                    c12 => a(12),
                    c13 => a(13),
                    c14 => a(14),
                    c15 => a(15),
                    s0 => s_mux(0),
                    s1 => s_mux(1),
                    s2 => s_mux(2),
                    s3 => s_mux(3),
                    y0 => u
        );
    demux: demux14
        port map(   c => u,
                    s1 => s_demux(0),
                    s2 => s_demux(1),
                    y0 => y(0),
                    y1 => y(1),
                    y2 => y(2),
                    y3 => y(3)
        );
end structural;

