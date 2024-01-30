library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux41 is 
    port(   mux_41_in  : in STD_LOGIC_VECTOR(3 downto 0);
            mux_41_sel : in STD_LOGIC_VECTOR(1 downto 0);
            mux_41_out  : out STD_LOGIC
    );
end mux41;

architecture structural of mux41 is
    signal u: STD_LOGIC_VECTOR(1 downto 0);
    component mux21 is 
        port(   mux_21_in  : in STD_LOGIC_VECTOR(1 downto 0);
                mux_21_sel  : in STD_LOGIC;
                mux_21_out  : out STD_LOGIC
        );
    end component;

begin 
    mux0: mux21
        port map( mux_21_in => mux_41_in(1 downto 0),
                  mux_21_sel => mux_41_sel(0),
                  mux_21_out => u(0)
        );
    mux1: mux21
        port map( mux_21_in => mux_41_in(3 downto 2),
                  mux_21_sel => mux_41_sel(0),
                  mux_21_out => u(1)
        );
    mux2: mux21
        port map( mux_21_in => u,
                  mux_21_sel => mux_41_sel(1),
                  mux_21_out => mux_41_out
        );
end structural;
