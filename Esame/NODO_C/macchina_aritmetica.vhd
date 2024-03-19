library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity macchina_aritmetica is
    port( clk_mac, rst_mac, start_mac: in std_logic;
          X_mac, Y_mac: in std_logic_vector(3 downto 0);		   
          Z_mac: out std_logic_vector(3 downto 0);
          fin_mac: out std_logic
    );
end macchina_aritmetica;

architecture structural of macchina_aritmetica is

    component molt_booth is 
        port( clock, reset, start: in std_logic;
              X, Y: in std_logic_vector(3 downto 0);		   
              product: out std_logic_vector(7 downto 0);
              stop_cu: out std_logic
        );



end structural;