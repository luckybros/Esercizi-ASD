library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity flip_flop_t is
    port(   clock, reset : in std_logic;
            Y : out std_logic);
end flip_flop_t;

architecture dataflow of flip_flop_t is
    signal TY : std_logic;

    begin 
    ff: process(clock, reset)
        begin
            if(reset = '1') then
                TY <= '0';
            elsif(clock'event AND clock = '0') then
                TY <= not TY;
            end if;
        end process;
    
    Y <= TY;

end dataflow;