library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity flipflopd is
    port(
        ck   : in STD_LOGIC;
        d    : in STD_LOGIC;
        q    : out STD_LOGIC
    );
end flipflopd;

architecture dataflow of flipflopd is
begin
    process (ck)
    begin
        if rising_edge(ck) then
            q <= d;
        end if;
    end process;
end dataflow;