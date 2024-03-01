library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use work.all;

entity mem is 
    port(
        address_mem    : in std_logic_vector(3 downto 0);
        data           : inout std_logic_vector(3 downto 0);
        clk_mem        : in std_logic;
        wrt            : in std_logic;
        out_value_mem  : out std_logic_vector(3 downto 0) 
    );
end entity mem;

architecture dataflow of mem is
    type MEMORY_16_4 is array (0 to 15) of std_logic_vector(3 downto 0); 
    signal MEM_16_4 : MEMORY_16_4 := (others => "0000"); 
    
begin
    process(clk_mem)
    begin
        if rising_edge(clk_mem) then
            if wrt = '1' then
                MEM_16_4(to_integer(unsigned(address_mem))) <= data;
                out_value_mem <= data;
            end if;
        end if;
    end process;

end architecture dataflow;