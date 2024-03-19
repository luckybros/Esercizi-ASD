library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity unita_operativa_c is 
    port( clk_uo_c : in std_logic;
          rst_uo_c : in std_logic;
          en_ctr_uo_c : in std_logic;
          wrt_uo_c : in std_logic;
          X_uo_c : in std_logic_vector(3 downto 0);
          Y_uo_c : in std_logic_vector(3 downto 0);
          cnt_uo_c : out std_logic_vector(2 downto 0);
          start_uo_c : in std_logic
    );
end unita_operativa_c;

architecture structural of unita_operativa_c is
    signal temp_address : std_logic_vector(3 downto 0);
    signal temp_Y_out : std_logic_vector(7 downto 0);
    signal temp_sum : std_logic_vector(7 downto 0) := "UUUUUUUU";

    component mem_c is 
        port(
            address_mem_c    : in std_logic_vector(2 downto 0);
            data             : in std_logic_vector(3 downto 0);
            clk_mem_c        : in std_logic;
            wrt              : in std_logic
        );
    end component;

    component counter_mod_8 is 
        port (
            clk_ctr, rst_ctr, en_ctr : in std_logic;
            curr_value : out std_logic_vector(2 downto 0)
        );
    end component;

    component molt_booth is
        port( clock, reset, start: in std_logic;
		   X, Y: in std_logic_vector(7 downto 0);		   
		   product: out std_logic_vector(15 downto 0);
		   stop_cu: out std_logic
        );

    

end structural; 