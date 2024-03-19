library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cont_mod4 is
    port(
        clock, reset: in std_logic;
        count_in: in std_logic;
        count: out std_logic_vector(1 downto 0)
    );
end cont_mod4;

architecture behavioural of cont_mod4 is
    signal c: std_logic_vector(1 downto 0) := (others=>'0');
begin
    CM4: process(clock)
    begin
        if(rising_edge(clock)) then 
            if(reset = '1') then 
                c <= (others=>'0');
            else 
                if(count_in = '1') then
                    c <= std_logic_vector(unsigned(c) + 1);
                end if;
            end if;
        end if;
    end process;
    
    count <= c;
    
end behavioural;
