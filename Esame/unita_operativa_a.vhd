library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity unita_operativa_a is 
    port( clk_uo_a : in std_logic;
          rst_uo_a : in std_logic;
          en_ctr_uo_a : in std_logic;
          rd_uo_a : in std_logic;
          cnt_uo_a : out std_logic_vector(2 downto 0);
          out_data_uo_a : out std_logic_vector(3 downto 0)
    );
end unita_operativa_A;

architecture structural of unita_operativa_a is
    signal temp_address : std_logic_vector(2 downto 0);
    signal temp_out : std_logic_vector(3 downto 0);

    component rom_a is 
    port(
        address_a : in std_logic_vector(2 downto 0);
        clk_a : in std_logic;
        rd_a : in std_logic;
        out_value_a : out std_logic_vector(3 downto 0) 
    );
    end component;

    component counter_mod_8 is 
    port (
        clk_ctr, rst_ctr, en_ctr : in std_logic;
        curr_value : out std_logic_vector(2 downto 0)
    );
    end component;

    begin
        memoria_a : rom_a
            port map( address_a => temp_address,
                      clk_a => clk_uo_a,
                      rd_a => rd_uo_a,
                      out_value_a => temp_out
            );

        ctr : counter_mod_8 
            port map( clk_ctr => clk_uo_a,
                      rst_ctr => rst_uo_a,
                      en_ctr => en_ctr_uo_a,
                      curr_value => temp_address
            );

        cnt_uo_A <= temp_address;
        out_data_uo_A <= temp_out;

end structural; 