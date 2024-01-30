library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux161 is 
    port(  c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, 
           c14, c15, s0, s1, s2, s3 : in STD_LOGIC;
           y1 : out STD_LOGIC
    );
end mux161;

architecture structural of mux161 is
    signal u0, u1, u2, u3 : STD_LOGIC;
    component mux41 is 
    port(   b0 : in STD_LOGIC;
            b1 : in STD_LOGIC;
            b2 : in STD_LOGIC;
            b3 : in STD_LOGIC;
            w0 : in STD_LOGIC;
            w1 : in STD_LOGIC;
            y0  : out STD_LOGIC
    );
    end component;

    begin 
    mux0: mux41
        port map( b0 => c0,
                  b1 => c1,
                  b2 => c2,
                  b3 => c3,
                  w0 => s0,
                  w1 => s1,
                  y0 => u0
        );
    mux1: mux41
        port map( b0 => c4,
                  b1 => c5,
                  b2 => c6,
                  b3 => c7,
                  w0 => s0,
                  w1 => s1,
                  y0 => u1
        );
    mux2: mux41
        port map( b0 => c8,
                  b1 => c9,
                  b2 => c10,
                  b3 => c11,
                  w0 => s0,
                  w1 => s1,
                  y0 => u2
        );
    mux3: mux41
        port map( b0 => c12,
                  b1 => c13,
                  b2 => c14,
                  b3 => c15,
                  w0 => s0,
                  w1 => s1,
                  y0 => u3
        );
    mux4: mux41
        port map( b0 => u0,
                  b1 => u1,
                  b2 => u2,
                  b3 => u3,
                  w0 => s2,
                  w1 => s3,
                  y0 => y1
        );
end structural;
