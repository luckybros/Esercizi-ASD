library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity nodo_c is
    port(
        start_c : in std_logic;
        clk_c : in std_logic;
        rst_c : in std_logic;
        accepted_a_c : out std_logic;
        accepted_b_c : out std_logic;
        data_ready_a_c : in std_logic;
        data_ready_b_c : in std_logic;
        X_C : in std_logic_vector(3 downto 0);
        Y_C : in std_logic_vector(3 downto 0)
    );
end nodo_c;

architecture structural of nodo_c is
    signal temp_wrt : std_logic;
    signal temp_cnt : std_logic_vector(2 downto 0);
    signal temp_en_ctr : std_logic; 
    signal temp_start_m : std_logic; 
    signal temp_end_m : std_logic; 
    
    component unita_controllo_c is
        port(   init : in std_logic;
                clock_cu_c : in std_logic;
                rst_cu_c : in std_logic;    
                write_c : out std_logic;
                count : in std_logic_vector(2 downto 0);
                en_ctr : out std_logic;
                accepted_a : out std_logic;
                accepted_b : out std_logic;
                data_ready_a : in std_logic;
                data_ready_b : in std_logic;
                start_m : out std_logic;
                end_m : in std_logic;
    );
    end component;

    component unita_operativa_c is 
        port(   clk_uo_c : in std_logic;
                rst_uo_c : in std_logic;
                en_ctr_uo_c : in std_logic;
                wrt_uo_c : in std_logic;
                start_uo_c : in std_logic
                X_uo_c : in std_logic_vector(3 downto 0);
                Y_uo_c : in std_logic_vector(3 downto 0);
                cnt_uo_c : out std_logic_vector(2 downto 0);
                end_uo_c : out std_logic;
    );
    end component;

begin
    uc_c : unita_controllo_c
        port map(
            init => start_c,
            clock_cu_c => clk_c,
            rst_cu_c => rst_c,
            write_c => temp_wrt,
            count => temp_cnt,
            en_ctr => temp_en_ctr,
            accepted_a => accepted_a_c,
            accepted_b => accepted_b_c,
            data_ready_a => data_ready_a_c,
            data_ready_b => data_ready_b_c,
            start_m => temp_start_m,
            end_m => temp_end_m
        );

    uo_c : unita_operativa_c
        port map(
            clk_uo_c => clk_c,
            rst_uo_c => rst_c,
            en_ctr_uo_c => temp_en_ctr,
            wrt_uo_c => temp_wrt,
            start_uo_c => temp_start_m, 
            X_uo_c => X_C,
            Y_uo_c => Y_C,
            cnt_uo_c => temp_cnt,
            end_up_c => temp_end_m
        );

end structural;
