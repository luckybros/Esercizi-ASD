library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity unita_operativa_B is 
    port( clk_uo_B : in std_logic;
          rst_uo_B : in std_logic;
          en_ctr_uo_B : in std_logic;
          rd_uo_B : in std_logic;
          wrt_uo_B : in std_logic;
          X_uo_B : in std_logic_vector(7 downto 0);
          cnt_uo_B : out std_logic_vector(3 downto 0);
          somma_uo_B : in std_logic
          --Y_uo_B : out std_logic_vector(7 downto 0);
          --Z_uo_B : out std_logic_vector(7 downto 0)
    );
end unita_operativa_B;

architecture structural of unita_operativa_B is
    signal temp_address : std_logic_vector(3 downto 0);
    signal temp_Y_out : std_logic_vector(7 downto 0);
    signal temp_sum : std_logic_vector(7 downto 0) := "UUUUUUUU";

    component memoria_B is 
    port(
        address : in std_logic_vector(3 downto 0);
        clk : in std_logic;
        rd : in std_logic;
        out_value : out std_logic_vector(7 downto 0) 
    );
    end component;

    component mem_B is 
    port(
        address_mem_B    : in std_logic_vector(3 downto 0);
        data           : in std_logic_vector(7 downto 0);
        clk_mem_B        : in std_logic;
        wrt            : in std_logic
        --out_value_mem_B  : out std_logic_vector(7 downto 0) 
    );
    end component;

    component counter_mod_16 is 
    port (
        clk_ctr, rst_ctr, en_ctr : in std_logic;
        curr_value : out std_logic_vector(3 downto 0)
    );
    end component;

    begin
        rom_B : memoria_B
            port map( address => temp_address,
                      clk => clk_uo_B,
                      rd => rd_uo_B,
                      out_value => temp_Y_out
            );

        ram_B : mem_B
            port map( address_mem_B => temp_address,
                      data => temp_sum,
                      clk_mem_B => clk_uo_B,
                      wrt => wrt_uo_B
                      --out_value_mem_B => Z_uo_B

            );

        ctr : counter_mod_16 
            port map( clk_ctr => clk_uo_B,
                      rst_ctr => rst_uo_B,
                      en_ctr => en_ctr_uo_B,
                      curr_value => temp_address
            );

        cnt_uo_B <= temp_address;
        --Y_uo_B <= temp_Y_out;
        temp_sum <= std_logic_vector(unsigned(temp_Y_out) + unsigned(X_uo_B)) when (somma_uo_B = '1');
        --Z_uo_B <= temp_sum;

end structural; 