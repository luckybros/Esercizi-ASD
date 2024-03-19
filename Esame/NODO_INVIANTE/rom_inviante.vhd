library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity rom_inviante is 
    port(
        address_inviante : in std_logic_vector(2 downto 0);
        clk_inviante : in std_logic;
        rd_inviante : in std_logic;
        out_value_inviante : out std_logic_vector(3 downto 0) 
    );
end entity rom_inviante;

architecture dataflow of rom_inviante is
    type MEMORY_8_4 is array (0 to 7) of std_logic_vector(3 downto 0); 
    constant memoria_inviante_8_4 : MEMORY_8_4 := (
        "0001", 
        "0010", 
        "0100", 
        "1000", 
        "0001", 
        "0001", 
        "0001", 
        "0010", 
    ); 
    
    begin
        process(clk)
        begin
            if(rising_edge(clk)) then
                if(rd = '1') then
                    out_value_inviante <= memoria_inviante_8_4(to_integer(unsigned(address)));
                end if;
            end if;
        end process;
    

end architecture dataflow;
