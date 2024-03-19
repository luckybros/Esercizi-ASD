library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity mem_c is 
    port(
        address_mem_c    : in std_logic_vector(2 downto 0);
        data             : in std_logic_vector(3 downto 0);
        clk_mem_c        : in std_logic;
        wrt              : in std_logic
    );
end entity mem_B;

architecture dataflow of mem_B is
    type MEMORY_8_4 is array (0 to 7) of std_logic_vector(3 downto 0); 
    signal mem_c_8_4 : MEMORY_8_4 := (others => "0000"); 
    
begin
    process(clk_mem_c)
    begin
        if rising_edge(clk_mem_c) then
            if wrt = '1' then
                mem_c_8_4(to_integer(unsigned(address_mem_c))) <= data;
            end if;
        end if;
    end process;

end architecture dataflow;
