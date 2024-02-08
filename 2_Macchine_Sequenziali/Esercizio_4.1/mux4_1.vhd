library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity mux41 is 
    port(   b0 : in STD_LOGIC;
            b1 : in STD_LOGIC;
            b2 : in STD_LOGIC;
            b3 : in STD_LOGIC;
            s0 : in STD_LOGIC;
            s1 : in STD_LOGIC;
            y0  : out STD_LOGIC
    );
end mux41;

architecture structural of mux41 is
    signal u0, u1 : STD_LOGIC;
    component mux21 is 
    port(   a0  :   in STD_LOGIC;
            a1  :   in STD_LOGIC;
            s   :   in STD_LOGIC;
            y   :   out STD_LOGIC
    );
    end component;

    begin 
        mux0: mux21
            port map( a0 => b0,
                      a1 => b1,
                      s => s0,
                      y => u0
            );
        mux1: mux21
            port map( a0 => b2,
                      a1 => b3,
                      s => s0,
                      y => u1
            );
        mux2: mux21
            port map( a0 => u0,
                      a1 => u1,
                      s => s1,
                      y => y0
            );
end structural;library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity mux41 is 
    port(   b0 : in STD_LOGIC;
            b1 : in STD_LOGIC;
            b2 : in STD_LOGIC;
            b3 : in STD_LOGIC;
            s0 : in STD_LOGIC;
            s1 : in STD_LOGIC;
            y0  : out STD_LOGIC
    );
end mux41;

architecture structural of mux41 is
    signal u0, u1 : STD_LOGIC;
    component mux21 is 
    port(   a0  :   in STD_LOGIC;
            a1  :   in STD_LOGIC;
            s   :   in STD_LOGIC;
            y   :   out STD_LOGIC
    );
    end component;

    begin 
        mux0: mux21
            port map( a0 => b0,
                      a1 => b1,
                      s => s0,
                      y => u0
            );
        mux1: mux21
            port map( a0 => b2,
                      a1 => b3,
                      s => s0,
                      y => u1
            );
        mux2: mux21
            port map( a0 => u0,
                      a1 => u1,
                      s => s1,
                      y => y0
            );
end structural;