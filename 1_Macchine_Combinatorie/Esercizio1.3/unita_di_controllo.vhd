library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_di_controllo is 
    port(   switch_in : in std_logic_vector(7 downto 0);
            buttons : in std_logic_vector(1 downto 0);
            switch_out : out std_logic_vector(15 downto 0)
    );
end unita_di_controllo;

architecture behavioral of unita_di_controllo is
    signal temp : std_logic_vector(15 downto 0) := (others => '0');

begin 
    process(buttons, switch_in)
        begin
            if(buttons(0) = '1') then
                temp(7 downto 0) <= switch_in;
            elsif(buttons(1) = '1') then
                temp(15 downto 8) <= switch_in;
            end if;
        end process;

    switch_out <= temp;
end behavioral;