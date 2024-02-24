library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity unita_operativa_A is 
    port( clk_uo_A : in std_logic;
          rst_uo_A : in std_logic;
          en_ctr_uo_A : in std_logic;
          rd_uo_A : in std_logic;
          cnt_uo_A : out std_logic_vector(3 downto 0);
          out_data_uo_A : out std_logic_vector(7 downto 0)
    );
end unita_operativa_A;

architecture structural of unita_operativa_A is
    signal temp_address : std_logic_vector(3 downto 0);
    signal temp_out : std_logic_vector(7 downto 0);

    component memoria_A is 
    port(
        address : in std_logic_vector(3 downto 0);
        clk : in std_logic;
        rd : in std_logic;
        out_value : out std_logic_vector(7 downto 0) 
    );
    end component;

    component counter_mod_16 is 
    port (
        clk_ctr, rst_ctr, en_ctr : in std_logic;
        curr_value : out std_logic_vector(3 downto 0)
    );
    end component;

    begin
        rom_A : memoria_A 
            port map( address => temp_address,
                      clk => clk_uo_A,
                      rd => rd_uo_A,
                      out_value => temp_out
            );

        ctr : counter_mod_16 
            port map( clk_ctr => clk_uo_A,
                      rst_ctr => rst_uo_A,
                      en_ctr => en_ctr_uo_A,
                      curr_value => temp_address
            );

        cnt_uo_A <= temp_address;
        out_data_uo_A <= temp_out;

end structural; 