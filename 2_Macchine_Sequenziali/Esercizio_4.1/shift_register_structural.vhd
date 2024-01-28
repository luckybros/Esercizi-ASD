library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity shift_register is 
    generic( n := integer 8 );
    port(   ei, clock', reset: in std_logic;
            choice : in std_logic_vector(1 downto 0);
            eo : out std_logic;
    );
end shift_register;

architecture structural of shift_register is 
    signal temp : std_logic_vector(n-1 downto 0);
    signal y_temp: std_logic_vector(n-1 downto 0);

    component mux4_1 is 
        port (  b0, b1, b2, b3, s0, s1  : in std_logic;
                y0  :   out std_logic;
        );
    end component;

    component flip_flop_d is
        port (  data, clock : in std_logic;
                uscita : out std_logic;
        );
    end component;

    begin 
        -- mux0: mux4_1 -- primo mux
            -- port map(
                --b0 => y_temp(1), -- shift a sinistra di 1
                --b1 => y_temp(2), -- shift a sinistra di 2
                --b2 => ei,   -- shift a destra di 1 
                --b3 => ei,   -- shift a destra di 2
                --s0 => s(0),
                --s1 => s(1),
                --y0 => temp(0)
            --);

        creazione_mux: for i in 0 to (n-2) generate
            mux : mux4_1
                port map (
                    b0 => y_temp(i+1) when (i+1) < n else ei,
                    b1 => y_temp(i+2) when (i+2) < n else ei,
                    b2 => y_temp(i-1) when (i-1) >= 0 else ei,
                    b2 => y_temp(i-2) when (i-2) >= 0 else ei,
                    s0 => s(0);
                    s1 => s(1),
                    y0 => temp(i)
                );
        end generate creazione_mux;

        creazione_flip_flop : for i in 0 to (n-1) generate
            flip_flop : flip_flop_d
                port map(   clock => clock', 
                            data => temp(i),
                            uscita => y_temp(i));
        
                            
        e0 <= y_temp(n-1);

end structural;