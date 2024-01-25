library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity net_16_4 is
    port(   a : in STD_LOGIC_VECTOR(15 downto 0);
            y : out STD_LOGIC_VECTOR(3 downto 0);
            mux_sel : STD_LOGIC_VECTOR(3 downto 0);
            demux_sel : STD_LOGIC_VECTOR(1 downto 0);
    );
end net_16_4;

architecture structural of net_16_4 is
    signal u : STD_LOGIC;

    component mux16_1 is
        port(   b   : in STD_LOGIC_VECTOR(15 downto 0);
                s0   : in STD_LOGIC_VECTOR(3 downto 0);
                y1  : out STD_LOGIC
        );
    end component;

    component demux_1_4 is 
        port(   c   : in STD_LOGIC;
                s1   : in STD_LOGIC_VECTOR(1 downto 0);
                y2  : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    begin
        mux : mux16_1 
            port map(   b => a,
                        s0 => mux_sel,
                        /* b(0) => a(0),
                        b(1) => a(1),
                        b(2) => a(2),
                        b(3) => a(3),
                        b(4) => a(4),
                        b(5) => a(5),
                        b(6) => a(6),
                        b(7) => a(7),
                        b(8) => a(8),
                        b(9) => a(9),
                        b(10) => a(10),
                        b(11) => a(11),
                        b(12) => a(12),
                        b(13) => a(13),
                        b(14) => a(14),
                        b(15) => a(15),
                        s0(0) => mux_sel(0),
                        s0(1) => mux_sel(1),
                        s0(2) => mux_sel(2),
                        s0(3) => mux_sel(3), */
                        y1 => u);
        demux : demux_1_4 
            port map(   c => u,
                        s1 => demux_sel,
                        y2 => y
                        /*s1(0) => demux_sel(0),
                        s1(1) => demux_sel(1),
                        y2(0) => y(0),
                        y2(1) => y(1),
                        y2(2) => y(2),
                        y2(3) => y(3)*/
            );
end structural;