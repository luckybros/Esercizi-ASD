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
    port(  mux161_c : in STD_LOGIC_VECTOR(15 downto 0);
           mux161_s : in STD_LOGIC_VECTOR(3 downto 0);
           mux161_y1 : out STD_LOGIC
    );
    end component;

    component demux14 is 
    port(   demux_14_in  : in STD_LOGIC;
            demux_14_sel : in STD_LOGIC_VECTOR(1 downto 0);
            demux_14_out : out STD_LOGIC_VECTOR(3 downto 0)
    );
    end component;

begin 
    net16_4_mux: mux161
        port map (  mux161_c => net16_4_a,
                    mux161_s => net16_4_s_mux,
                    mux161_y1 => net16_4_u
        );
    net16_4_demux: demux14
        port map(   demux_14_in => net16_4_u,
                    demux_14_sel => net16_4_s_demux,
                    demux_14_out => net16_4_y
        );
end structural;
