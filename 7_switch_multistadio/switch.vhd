library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity switch is 
    port(
        x_switch: in STD_LOGIC_VECTOR(1 downto 0);
        sel: in STD_LOGIC_VECTOR(1 downto 0);
        y_switch: out STD_LOGIC_VECTOR(1 downto 0)
    );
end switch;

architecture structural of switch is

    component mux21 is 
    port(
        a0  : in STD_LOGIC;
        a1  : in STD_LOGIC;
        s   : in STD_LOGIC;
        y   : out STD_LOGIC
    );
    end component;

    component demux12 is 
    port(
        demux_12_in  : in STD_LOGIC;
        demux_12_sel : in STD_LOGIC;
        demux_12_out : out STD_LOGIC_VECTOR(1 downto 0)
    );
    end component;

    signal temp : STD_LOGIC;

begin

    -- MUX instance
    mux: mux21
        port map(
            a0 => x_switch(0),
            a1 => x_switch(1),
            s  => sel(0),
            y  => temp
        );

    -- DEMUX instance
    demux: demux12
        port map(
            demux_12_in  => temp,
            demux_12_sel => sel(1),
            demux_12_out => y_switch 
        );

end structural;
