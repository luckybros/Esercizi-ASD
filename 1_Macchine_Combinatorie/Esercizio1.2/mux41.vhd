library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux41 is 
    port(   mux_41_in0  : in STD_LOGIC;
            mux_41_in1  : in STD_LOGIC;
            mux_41_in2  : in STD_LOGIC;
            mux_41_in3  : in STD_LOGIC;
            mux_41_sel0 : in STD_LOGIC;
            mux_41_sel1 : in STD_LOGIC;
            mux_41_out  : out STD_LOGIC
    );
end mux41;

architecture structural of mux41 is
    signal u0, u1 : STD_LOGIC;
    component mux21 is 
        port(   mux_21_in0  : in STD_LOGIC;
                mux_21_in1  : in STD_LOGIC;
                mux_21_sel  : in STD_LOGIC;
                mux_21_out  : out STD_LOGIC
        );
    end component;

begin 
    mux0: mux21
        port map( mux_21_in0 => mux_41_in0,
                  mux_21_in1 => mux_41_in1,
                  mux_21_sel => mux_41_sel0,
                  mux_21_out => u0
        );
    mux1: mux21
        port map( mux_21_in0 => mux_41_in2,
                  mux_21_in1 => mux_41_in3,
                  mux_21_sel => mux_41_sel0,
                  mux_21_out => u1
        );
    mux2: mux21
        port map( mux_21_in0 => u0,
                  mux_21_in1 => u1,
                  mux_21_sel => mux_41_sel1,
                  mux_21_out => mux_41_out
        );
end structural;
