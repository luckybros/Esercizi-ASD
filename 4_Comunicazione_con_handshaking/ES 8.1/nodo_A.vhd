library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity nodo_A is
    port(
        start_A : in std_logic;
        clk_A : in std_logic;
        rst_A : in std_logic;
        accepted_A : in std_logic;
        data_ready_A : out std_logic;
        X : out std_logic_vector(7 downto 0)
    );
end nodo_A;

architecture structural of nodo_A is
    signal temp_rd : std_logic;
    signal temp_cnt : std_logic_vector(3 downto 0);
    signal temp_en_ctr : std_logic;  -- Rinominato da temp_en_cnt per chiarezza
    
    component unitacontrollo_A is
        port(
            init : in std_logic;
            clk_cu_A : in std_logic;
            rst_cu_A : in std_logic;
            read_A : out std_logic;
            count : in std_logic_vector(3 downto 0);
            en_ctr : out std_logic;
            accepted : in std_logic;
            data_ready : out std_logic
        );
    end component;

    component unita_operativa_A is
        port(
            clk_uo_A : in std_logic;
            rst_uo_A : in std_logic;
            en_ctr_uo_A : in std_logic;
            rd_uo_A : in std_logic;
            cnt_uo_A : out std_logic_vector(3 downto 0);
            out_data_uo_A : out std_logic_vector(7 downto 0)
        );
    end component;

begin
    uc_A : unitacontrollo_A 
        port map(
            init => start_A,
            clk_cu_A => clk_A,
            rst_cu_A => rst_A,
            read_A => temp_rd,
            count => temp_cnt,
            en_ctr => temp_en_ctr,
            accepted => accepted_A,
            data_ready => data_ready_A
        );

    uo_A : unita_operativa_A
        port map(
            clk_uo_A => clk_A,
            rst_uo_A => rst_A,
            en_ctr_uo_A => temp_en_ctr,
            rd_uo_A => temp_rd,
            cnt_uo_A => temp_cnt,
            out_data_uo_A => X
        );

end structural;
