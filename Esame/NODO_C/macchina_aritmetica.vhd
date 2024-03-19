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

    signal temp_ris : std_logic_vector(3 downto 0);
    signal temp_stop_cu : std_logic;

    component molt_booth is 
        port( clock, reset, start: in std_logic;
              X, Y: in std_logic_vector(3 downto 0);		   
              product: out std_logic_vector(7 downto 0);
              stop_cu: out std_logic
        );
    end component;

    component operatore_modulo is 
        port (
            clk_modulo : in std_logic;
            rst_modulo : in std_logic;
            a_modulo : in std_logic_vector(7 downto 0);
            b_modulo : in std_logic_vector(3 downto 0);
            result_modulo : out std_logic_vector(3 downto 0);
            end_modulo : out std_logic
        );
    end component;

    begin
        moltiplicatore : molt_booth is
            port map( clock => clk_mac,
                      reset => rst_mac,
                      start => start_mac,
                      X => X_mac,
                      Y => X_mac,
                      Z => temp_ris,
                      stop_cu => temp_stop_cu
            );

        modulo : operatore_modulo is
            port map(  clk_modulo => clk_mac,
                       rst_modulo => rst_mac, 
                       a_modulo => temp_ris, 
                       b_modulo => Y_mac, 
                       result_modulo => Z_mac,
                       end_modulo => fin_mac            
            );

end structural;