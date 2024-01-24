library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity mux16_1 is
    port(   c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, 
        c13, c14, c15, t0, t1, t2, t3   :   in STD_LOGIC; 
            y1  :   out STD_LOGIC;
    );
end mux16_1;

architecture structural of mux16_1 is
    signal u0, u1, u2, u3 :  STD_LOGIC;

    component mux21 is 
    port(   a0, a1, s  :   in STD_LOGIC;
                y   :   out STD_LOGIC;
        );
    end component;

    component mux41 is 
        port(   b0, b1, b2, b3, s0, s1  : in STD_LOGIC;
            y0  :   out STD_LOGIC;
        );
    end component;

    begin
        mux0: mux41
            port map(   b0 => c0,
                        b1 => c1,
                        b2 => c2,
                        b3 => c3,
                        s0 => t0,
                        s1 => t1,
                        y0 => u0);
        mux1: mux41
            port map(   b0 => c4,
                        b1 => c5,
                        b2 => c6,
                        b3 => c7,
                        s0 => t0,
                        s1 => t1,
                        y0 => u1);
        mux2: mux41
            port map(   b0 => c8,
                        b1 => c9,
                        b2 => c10,
                        b3 => c11,
                        s0 => t0,
                        s1 => t1,
                        y0 => u2);
        mux3: mux41
            port map(   b0 => c12,
                        b1 => c13,
                        b2 => c14,
                        b3 => c15,
                        s0 => t0,
                        s1 => t1,
                        y0 => u3);
        mux4: mux41
            port map(   b0 => u0,
                        b1 => u1,
                        b2 => u2,
                        b3 => u3,
                        s0 => t2,
                        s1 => t3,
                        y0 => y);
end structural;