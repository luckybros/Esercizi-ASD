library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity timer is 
    port(   clock, reset : in std_logic;
            set_seconds : in integer range 0 to 59;
            set_minutes : in integer range 0 to 59;
            set_hours : in integer range 0 to 23;);
end timer;