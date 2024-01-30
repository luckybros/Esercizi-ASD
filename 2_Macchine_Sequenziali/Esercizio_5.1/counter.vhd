library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity counter is 
    generic(n := integer 8);
    port(   clock, reset : in std_logic;
            inital_value : in integer;
            max_value : out std_logic;  -- uscita quando si raggiunge il valore di modulo
            out_value : out integer; -- valore di conteggio attuale
    );
end counter;

architecture behavioral of counter is

    variable current_value : integer := initial_value;
    signal temp : std_logic <= '0';

    begin
    mod_n: process(clock, reset)
        begin
        if(reset = '1') then
            temp <= '0';
            current_value := inital_value;
        elsif(rising_edge(clock)) then
            current_value := current_value + 1;
            if(current_value = n) then
                reset <= '1';
                temp <= '1';
            end if;
        end if;
    end mod_n;

    out_value := current_value;
    max_value <= temp;

end behavioral;