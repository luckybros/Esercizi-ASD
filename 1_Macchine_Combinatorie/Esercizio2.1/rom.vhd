library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity rom is 
    port(
        address : in std_logic_vector(3 downto 0);
        out_value : out std_logic_vector(7 downto 0) 
    );
end entity rom;

architecture RTL of rom is
    type MEMORY_16_8 is array (0 to 15) of std_logic_vector(7 downto 0); 
    constant ROM_16_8 : MEMORY_16_8 := (
        "00010001", 
        "00100010", 
        "01000100", 
        "10001000", 
        "00010010", 
        "00010100", 
        "00011000", 
        "00100001", 
        "00100100", 
        "00101000", 
        "01000001", 
        "01000010", 
        "01001000", 
        "10000001", 
        "10000100", 
        "10000010"
    ); 
begin
    out_value <= ROM_16_8(to_integer(unsigned(address)));
end architecture RTL;
