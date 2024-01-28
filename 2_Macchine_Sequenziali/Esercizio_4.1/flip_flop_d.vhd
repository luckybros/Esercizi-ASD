library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity flip_flop_d is
    port(   data, clock : in STD_LOGIC;
            uscita : out STD_LOGIC;
    );
end flip_flop_d;

architecture dataflow of flip_flop_d is

    process(clock)
    begin 
        if rising_edge(clock) then 
            uscita <= data;
        end if;
    end process;

end dataflow;
