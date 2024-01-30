library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux161 is 
    port(  mux161_c0, mux161_c1, mux161_c2, mux161_c3, mux161_c4, mux161_c5, mux161_c6, mux161_c7,
           mux161_c8, mux161_c9, mux161_c10, mux161_c11, mux161_c12, mux161_c13, mux161_c14, mux161_c15,
           mux161_s0, mux161_s1, mux161_s2, mux161_s3 : in STD_LOGIC;
           mux161_y1 : out STD_LOGIC
    );
end mux161;

architecture structural of mux161 is
    signal mux161_u0, mux161_u1, mux161_u2, mux161_u3, mux161_u4 : STD_LOGIC;
    component mux41 is 
        port(   mux_41_in0 : in STD_LOGIC;
                mux_41_in1 : in STD_LOGIC;
                mux_41_in2 : in STD_LOGIC;
                mux_41_in3 : in STD_LOGIC;
                mux_41_sel0 : in STD_LOGIC;
                mux_41_sel1 : in STD_LOGIC;
                mux_41_out  : out STD_LOGIC
        );
    end component;

begin 
    mux161_mux0: mux41
        port map( mux_41_in0 => mux161_c0,
                  mux_41_in1 => mux161_c1,
                  mux_41_in2 => mux161_c2,
                  mux_41_in3 => mux161_c3,
                  mux_41_sel0 => mux161_s0,
                  mux_41_sel1 => mux161_s1,
                  mux_41_out => mux161_u0
        );
    mux161_mux1: mux41
        port map( mux_41_in0 => mux161_c4,
                  mux_41_in1 => mux161_c5,
                  mux_41_in2 => mux161_c6,
                  mux_41_in3 => mux161_c7,
                  mux_41_sel0 => mux161_s0,
                  mux_41_sel1 => mux161_s1,
                  mux_41_out => mux161_u1
        );
    mux161_mux2: mux41
        port map( mux_41_in0 => mux161_c8,
                  mux_41_in1 => mux161_c9,
                  mux_41_in2 => mux161_c10,
                  mux_41_in3 => mux161_c11,
                  mux_41_sel0 => mux161_s0,
                  mux_41_sel1 => mux161_s1,
                  mux_41_out => mux161_u2
        );
    mux161_mux3: mux41
        port map( mux_41_in0 => mux161_c12,
                  mux_41_in1 => mux161_c13,
                  mux_41_in2 => mux161_c14,
                  mux_41_in3 => mux161_c15,
                  mux_41_sel0 => mux161_s0,
                  mux_41_sel1 => mux161_s1,
                  mux_41_out => mux161_u3
        );
    mux161_mux4: mux41
        port map( mux_41_in0 => mux161_u0,
                  mux_41_in1 => mux161_u1,
                  mux_41_in2 => mux161_u2,
                  mux_41_in3 => mux161_u3,
                  mux_41_sel0 => mux161_s2,
                  mux_41_sel1 => mux161_s3,
                  mux_41_out => mux161_u4
        );
end structural;
