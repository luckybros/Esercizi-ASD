library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity counter_mod_8 is 
    port (
        clk_ctr, rst_ctr, en_ctr : in std_logic;
        curr_value : out std_logic_vector(2 downto 0)
    );
end counter_mod_8;

architecture behavioral of counter_mod_16 is
    signal current_value : std_logic_vector(2 downto 0) := "000";

begin
    mod_8: process(clk_ctr, rst_ctr)
    begin
        if rst_ctr = '1' then
            current_value <= "000";
        elsif rising_edge(clk_ctr) then
            if en_ctr = '1' then
                current_value <= std_logic_vector(unsigned(current_value) + 1);
                if current_value = "111" then
                    current_value <= "0000";
                end if;
            end if;
        end if;
    end process mod_8;

    curr_value <= current_value;

end behavioral;

