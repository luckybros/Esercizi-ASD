library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity unita_operativa_c is 
    port( clk_uo_c : in std_logic;
          rst_uo_c : in std_logic;
          en_ctr_uo_c : in std_logic;
          wrt_uo_c : in std_logic;
          start_uo_c : in std_logic
          X_uo_c : in std_logic_vector(3 downto 0);
          Y_uo_c : in std_logic_vector(3 downto 0);
          cnt_uo_c : out std_logic_vector(2 downto 0);
          end_uo_c : out std_logic;
    );
end unita_operativa_c;

architecture structural of unita_operativa_c is
    signal temp_address : std_logic_vector(2 downto 0);
    signal temp_out : std_logic_vector(3 downto 0);

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

    component macchina_aritmetica is
        port( clk_mac, rst_mac, start_mac: in std_logic;
		   X_mac, Y_mac: in std_logic_vector(3 downto 0);		   
		   Z_mac: out std_logic_vector(3 downto 0);
		   fin_mac: out std_logic
        );
    end component;

    begin 
        memoria_c : mem_c
            port map ( address_mem_c => temp_address, 
                       data => temp_out,
                       clk_mem_c => clk_uo_c, 
                       wrt => wrt_uo_c
            );

        ctr : counter_mod_8 
            port map (  clk_ctr => clk_uo_c,
                        rst_ctr => rst_uo_c,
                        en_ctr => en_ctr_uo_c,
                        curr_value => temp_address
            );

        macchina : macchina_aritmetica 
            port map (  clk_mac => clk_uo_c,
                        rst_mac => rst_uo_c,
                        start_mac => start_uo_c,
                        X_mac => X_uo_c,
                        Y_mac => Y_uo_c,
                        Z_mac => temp_out,
                        fin_mac => end_uo_c
            );

        cnt_uo_c <= temp_address;
        
end structural; 