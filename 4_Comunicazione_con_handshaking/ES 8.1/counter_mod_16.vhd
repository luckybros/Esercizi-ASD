library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity counter_mod_16 is 
    port (
        clk_ctr, rst_ctr, en_ctr : in std_logic;
        curr_value : out std_logic_vector(3 downto 0)
    );
end counter_mod_16;

architecture behavioral of counter_mod_16 is
    signal current_value : std_logic_vector(3 downto 0) := "0000";

begin
    mod_16: process(clk_ctr, rst_ctr)
    begin
        if rst_ctr = '1' then
            current_value <= "0000";
        elsif rising_edge(clk_ctr) then
            if en_ctr = '1' then
                current_value <= std_logic_vector(unsigned(current_value) + 1);
                if current_value = "1111" then
                    current_value <= "0000";
                end if;
            end if;
        end if;
    end process mod_16;

    curr_value <= current_value;

end behavioral;

