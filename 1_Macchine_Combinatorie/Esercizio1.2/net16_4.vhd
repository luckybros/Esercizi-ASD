library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity net16_4 is
    port(   net16_4_a : in STD_LOGIC_VECTOR(15 downto 0);
            net16_4_s_mux : in STD_LOGIC_VECTOR(3 downto 0);
            net16_4_s_demux : in STD_LOGIC_VECTOR(1 downto 0);
            net16_4_y : out STD_LOGIC_VECTOR(3 downto 0)
    );
end net16_4;

architecture structural of net16_4 is
    signal net16_4_u : STD_LOGIC;

    component mux161 is 
    port(  mux161_c0, mux161_c1, mux161_c2, mux161_c3, mux161_c4, mux161_c5, mux161_c6, mux161_c7,
           mux161_c8, mux161_c9, mux161_c10, mux161_c11, mux161_c12, mux161_c13, mux161_c14, mux161_c15,
           mux161_s0, mux161_s1, mux161_s2, mux161_s3 : in STD_LOGIC;
           mux161_y1 : out STD_LOGIC
    );
    end component;

    component demux14 is 
    port(   demux_14_in : in STD_LOGIC;
            demux_14_sel1 : in STD_LOGIC;
            demux_14_sel2 : in STD_LOGIC;
            demux_14_out0 : out STD_LOGIC;
            demux_14_out1 : out STD_LOGIC;
            demux_14_out2 : out STD_LOGIC;
            demux_14_out3 : out STD_LOGIC
    );
    end component;

begin 
    net16_4_mux: mux161
        port map(   mux161_c0 => net16_4_a(0),
                    mux161_c1 => net16_4_a(1),
                    mux161_c2 => net16_4_a(2),
                    mux161_c3 => net16_4_a(3),
                    mux161_c4 => net16_4_a(4),
                    mux161_c5 => net16_4_a(5),
                    mux161_c6 => net16_4_a(6),
                    mux161_c7 => net16_4_a(7),
                    mux161_c8 => net16_4_a(8),
                    mux161_c9 => net16_4_a(9),
                    mux161_c10 => net16_4_a(10),
                    mux161_c11 => net16_4_a(11),
                    mux161_c12 => net16_4_a(12),
                    mux161_c13 => net16_4_a(13),
                    mux161_c14 => net16_4_a(14),
                    mux161_c15 => net16_4_a(15),
                    mux161_s0 => net16_4_s_mux(0),
                    mux161_s1 => net16_4_s_mux(1),
                    mux161_s2 => net16_4_s_mux(2),
                    mux161_s3 => net16_4_s_mux(3),
                    mux161_y1 => net16_4_u
        );
    net16_4_demux: demux14
        port map(   demux_14_in => net16_4_u,
                    demux_14_sel1 => net16_4_s_demux(0),
                    demux_14_sel2 => net16_4_s_demux(1),
                    demux_14_out0 => net16_4_y(0),
                    demux_14_out1 => net16_4_y(1),
                    demux_14_out2 => net16_4_y(2),
                    demux_14_out3 => net16_4_y(3)
        );
end structural;
