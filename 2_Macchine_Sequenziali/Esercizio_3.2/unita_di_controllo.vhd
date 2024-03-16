library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_di_controllo is 
    port(   switch_in_1 : in std_logic;
            switch_in_2 : in std_logic;
            button_1 : in std_logic;
            button_2 : in std_logic;
            clk_cu : in std_logic;
            switch_out_data : out std_logic;
            switch_out_mode : out std_logic
    );
end unita_di_controllo;

architecture behavioral of unita_di_controllo is
    signal temp_data : std_logic;
    signal temp_mode : std_logic;

    begin
        process(clk_cu, button_1, button_2, switch_in_1, switch_in_2)
            begin 
            if(rising_edge(clk_cu)) then
                if(button_1 = '1') then
                    temp_data <= switch_in_1;
                end if;
                if(button_2 = '1') then
                    temp_mode <= switch_in_2;
                end if;
            end if;
        end process;

    switch_out_data <= temp_data;
    switch_out_mode <= temp_mode;

end behavioral;