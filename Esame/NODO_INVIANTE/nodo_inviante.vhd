library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity nodo_inviante is
    port(
        start_inviante : in std_logic;
        clk_inviante : in std_logic;
        rst_inviante : in std_logic;
        accepted_inviante : in std_logic;
        data_ready_inviante : out std_logic;
        out_value_inviante : out std_logic_vector(3 downto 0)
    );
end nodo_inviante;

architecture structural of nodo_inviante is
    signal temp_rd : std_logic;
    signal temp_cnt : std_logic_vector(2 downto 0);
    signal temp_en_ctr : std_logic;  
    
    component unita_controllo_inviante is
        port(
            init : in std_logic;
            clk_cu_inviante : in std_logic;
            rst_cu_inviante : in std_logic;
            read_inviante : out std_logic;
            count : in std_logic_vector(2 downto 0);
            en_ctr : out std_logic;
            accepted : in std_logic;
            data_ready : out std_logic
        );
    end component;

    component unita_operativa_inviante is
        port(
            clk_uo_inviante : in std_logic;
            rst_uo_inviante : in std_logic;
            en_ctr_uo_inviante : in std_logic;
            rd_uo_inviante : in std_logic;
            cnt_uo_inviante : out std_logic_vector(2 downto 0);
            out_data_uo_inviante : out std_logic_vector(3 downto 0)
        );
    end component;

begin
    uc_inviante : unitacontrollo_inviante 
        port map(
            init => start_inviante,
            clk_cu_inviante => clk_inviante,
            rst_cu_inviante => rst_inviante,
            read_inviante => temp_rd,
            count => temp_cnt,
            en_ctr => temp_en_ctr,
            accepted => accepted_inviante,
            data_ready => data_ready_inviante
        );

    uo_inviante : unita_operativa_inviante
        port map(
            clk_uo_inviante => clk_inviante,
            rst_uo_inviante => rst_inviante,
            en_ctr_uo_inviante => temp_en_ctr,
            rd_uo_inviante => temp_rd,
            cnt_uo_inviante => temp_cnt,
            out_data_uo_inviante => X
        );

end structural;
