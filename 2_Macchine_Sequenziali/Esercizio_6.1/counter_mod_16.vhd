library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity counter_mod_16 is 
    port (
        clk_ctr, rst_ctr, en_ctr : in std_logic;
        curr_value : out std_logic_vector(3 downto 0);
        out_ctr : out std_logic
    );
end counter_mod_16;

architecture behavioral of counter_mod_16 is
    signal current_value : std_logic_vector(3 downto 0) := "0000";
    signal exit_ctr : std_logic := '0';
    signal temp_value : unsigned(3 downto 0);

begin
    mod_16: process(clk_ctr, rst_ctr)
    begin
        if rst_ctr = '1' then
            current_value <= "0000";
        elsif rising_edge(clk_ctr) then
            if en_ctr = '1' then
                temp_value <= unsigned(current_value) + 1;
                current_value <= std_logic_vector(temp_value);
                if current_value = "1111" then
                    current_value <= "0000";
                    exit_ctr <= '1';
                else
                    exit_ctr <= '0';
                end if;
            end if;
        end if;
    end process mod_16;

    curr_value <= current_value;
    out_ctr <= exit_ctr;

end behavioral;
