library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux161 is 
    port(  mux161_c : in STD_LOGIC_VECTOR(15 downto 0);
           mux161_s : in STD_LOGIC_VECTOR(3 downto 0);
           mux161_y1 : out STD_LOGIC
    );
end mux161;

architecture structural of mux161 is
    signal mux161_u: STD_LOGIC_VECTOR(3 downto 0);
    component mux41 is 
        port(   mux_41_in  : in STD_LOGIC_VECTOR(3 downto 0);
                mux_41_sel : in STD_LOGIC_VECTOR(1 downto 0);
                mux_41_out  : out STD_LOGIC
        );  
    end component;

begin 
    mux161_mux0: mux41
        port map( mux_41_in => mux161_c(3 downto 0),
                  mux_41_sel => mux161_s(1 downto 0),
                  mux_41_out => mux161_u(0)
        );
    mux161_mux1: mux41
        port map( mux_41_in => mux161_c(7 downto 4),
                  mux_41_sel => mux161_s(1 downto 0),
                  mux_41_out => mux161_u(1)
        );
    mux161_mux2: mux41
        port map( mux_41_in => mux161_c(11 downto 8),
                  mux_41_sel => mux161_s(1 downto 0),
                  mux_41_out => mux161_u(2)
        );
    mux161_mux3: mux41
        port map( mux_41_in => mux161_c(15 downto 12),
                  mux_41_sel => mux161_s(1 downto 0),
                  mux_41_out => mux161_u(3)
        );
    mux161_mux4: mux41
        port map( mux_41_in => mux161_u, 
                  mux_41_sel => mux161_s(3 downto 2),
                  mux_41_out => mux161_y1
        );
end structural;
