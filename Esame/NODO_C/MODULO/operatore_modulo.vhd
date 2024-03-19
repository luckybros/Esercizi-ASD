library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity operatore_modulo is
    port (
        clk_modulo : in std_logic;
        rst_modulo : in std_logic;
        a_modulo : in std_logic_vector(7 downto 0);
        b_modulo : in std_logic_vector(3 downto 0);
        result_modulo : out std_logic_vector(3 downto 0);
        end_modulo : out std_logic
    );
end operatore_modulo;

architecture behavioral of operatore_modulo is
    signal int_a, int_b, mod_result : integer := 0;
begin
    process(clk_modulo, rst_modulo)
    begin
        if rst = '1' then
            int_a <= 0;
            int_b <= 0;
            mod_result <= 0;
            result <= (others => '0');
            
        elsif rising_edge(clk) then
            int_a <= to_integer(unsigned(a_modulo));
            int_b <= to_integer(unsigned(b_modulo));
            
            mod_result <= int_a mod int_b;
            
            if mod_result < 0 then
                mod_result <= mod_result + int_b;
            end if;
            
            result <= std_logic_vector(to_unsigned(mod_result, result'length));
            end_modulo <= '1';
        end if;
    end process;
end behavioral;
