entity mux4_1 is 
    port(   b0 : in std_logic;
            b1 : in std_logic;
            b2 : in std_logic;
            b3 : in std_logic;
            s0 : in std_logic;
            s1 : in std_logic;
            y0 : out std_logic;
    );
end mux4_1;

architecture structural of mux4_1 is
    signal u0 : std_logic := '0';
    signal u1 : std_logic := '0';

    component mux2_1
        port(   a0 : in std_logic;
                a1: in std_logic;
                s : in std_logic;
                y : out std_logic;
        );
    end component;

    begin 
        mux0: mux2_1
            Port map(   a0 => b0,
                        a1 => b1,
                        s => s0,
                        y => u0,
            );

        mux1: mux2_1
            Port map(   a0 => b2,
                        a1 => b4,
                        s => s0,
                        y => u1,
            );

        mux2: mux2_1
            Port map(   a0 => u0,
                        a1 => u1,
                        s => s1,
                        y => y0,
            );
end structural;