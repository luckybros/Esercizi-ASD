library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity rom is 
    port(
        address : in std_logic_vector(3 downto 0);
        out_value : out std_logic_vector(7 downto 0) 
    );
end entity rom;

architecture rtl of rom is
    -- si riempie la memoria con due numeri perché i valori sono su 8 bit (4 e 4)
    type memory_16_8 is array (0 to 15) of std_logic_vector(7 downto 0); 
    constant rom_16_8 : memory_16_8 := (   
        x"00", x"11", x"22", x"33", 
        x"44", x"55", x"66", x"77", 
        x"88", x"99", x"aa", x"bb", 
        x"cc", x"dd", x"ee", x"ff"
    ); 
    begin
        out_value <= rom_16_8(to_integer(unsigned(address)));        

end architecture rtl;
