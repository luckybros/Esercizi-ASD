library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity memoria_A is 
    port(
        address : in std_logic_vector(2 downto 0);
        clk : in std_logic;
        rd : in std_logic;
        out_value : out std_logic_vector(7 downto 0) 
    );
end entity memoria_A;

architecture dataflow of memoria_A is
    type MEMORY_8_8 is array (0 to 7) of std_logic_vector(7 downto 0); 
    constant memoria_A_8_8 : MEMORY_8_8 := (
        "00010001", 
        "00100010", 
        "01000100", 
        "10001000", 
        "00010010", 
        "00010100", 
        "00011000", 
        "00100001"
    ); 
    
    begin
        process(clk)
        begin
            if(rising_edge(clk)) then
                if(rd = '1') then
                    out_value <= memoria_A_8_8(to_integer(unsigned(address)));
                end if;
            end if;
        end process;
    

end architecture dataflow;

