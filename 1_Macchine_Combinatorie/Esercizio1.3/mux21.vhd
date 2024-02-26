library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux21 is 
    port(   mux_21_in  : in STD_LOGIC_VECTOR(1 downto 0);
            mux_21_sel  : in STD_LOGIC;
            mux_21_out  : out STD_LOGIC
    );
end mux21;

architecture dataflow of mux21 is
begin
    mux_21_out <= ((mux_21_in(0) AND (NOT mux_21_sel)) OR (mux_21_in(1) AND mux_21_sel));
end dataflow;
