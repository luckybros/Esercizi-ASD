library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity unita_operativa_inviante is 
    port( clk_uo_inviante : in std_logic;
          rst_uo_inviante : in std_logic;
          en_ctr_uo_inviante : in std_logic;
          rd_uo_inviante : in std_logic;
          cnt_uo_inviante : out std_logic_vector(2 downto 0);
          out_data_uo_inviante : out std_logic_vector(3 downto 0)
    );
end unita_operativa_inviante;

architecture structural of unita_operativa_inviante is
    signal temp_invianteddress : std_logic_vector(2 downto 0);
    signal temp_out : std_logic_vector(3 downto 0);

    component rom_inviante is 
    port(
        address_inviante : in std_logic_vector(2 downto 0);
        clk_inviante : in std_logic;
        rd_inviante : in std_logic;
        out_value_inviante : out std_logic_vector(3 downto 0) 
    );
    end component;

    component counter_mod_8 is 
    port (
        clk_ctr, rst_ctr, en_ctr : in std_logic;
        curr_value : out std_logic_vector(2 downto 0)
    );
    end component;

    begin
        memoria_inviante : rom_inviante
            port map( address_inviante => temp_invianteddress,
                      clk_inviante => clk_uo_inviante,
                      rd_inviante => rd_uo_inviante,
                      out_value_inviante => temp_out
            );

        ctr : counter_mod_8 
            port map( clk_ctr => clk_uo_inviante,
                      rst_ctr => rst_uo_inviante,
                      en_ctr => en_ctr_uo_inviante,
                      curr_value => temp_invianteddress
            );

        cnt_uo_inviante <= temp_invianteddress;
        out_data_uo_inviante <= temp_out;

end structural; 