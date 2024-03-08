library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity mem_B is 
    port(
        address_mem_B    : in std_logic_vector(2 downto 0);
        data             : in std_logic_vector(7 downto 0);
        clk_mem_B        : in std_logic;
        wrt              : in std_logic
    );
end entity mem_B;

architecture dataflow of mem_B is
    type MEMORY_8_8 is array (0 to 7) of std_logic_vector(7 downto 0); 
    signal mem_B_8_8 : MEMORY_8_8 := (others => "00000000"); 
    
begin
    process(clk_mem_B)
    begin
        if rising_edge(clk_mem_B) then
            if wrt = '1' then
                mem_B_8_8(to_integer(unsigned(address_mem_B))) <= data;
                --out_value_mem_B <= data;
            end if;
        end if;
    end process;

end architecture dataflow;
