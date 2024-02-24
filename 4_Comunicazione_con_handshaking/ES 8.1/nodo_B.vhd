library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity nodo_B is
    port(
        start_B : in std_logic;
        clk_B : in std_logic;
        rst_B : in std_logic;
        accepted_B : out std_logic;
        data_ready_B : in std_logic;
        X_B : in std_logic_vector(7 downto 0)
        --Z_B : out std_logic_vector(7 downto 0)
    );
end nodo_B;

architecture structural of nodo_B is
    signal temp_rd : std_logic;
    signal temp_wrt : std_logic;
    signal temp_cnt : std_logic_vector(3 downto 0);
    signal temp_en_ctr : std_logic; 
    signal temp_somma : std_logic; 
    
    component unitacontrollo_B is
        port(   
            init : in std_logic;
            clock_cu_B : in std_logic;
            rst_cu_B : in std_logic;
            read_B : out std_logic;
            write_B : out std_logic;
            count : in std_logic_vector(3 downto 0);
            en_ctr : out std_logic;
            accepted : out std_logic;
            data_ready : in std_logic;
            somma : out std_logic
            --X : in std_logic_vector(7 downto 0);
            --Y : in std_logic_vector(7 downto 0);
            --Z : out std_logic_vector(7 downto 0)
        );
    end component;

    component unita_operativa_B is 
        port( 
            clk_uo_B : in std_logic;
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
    end component;

begin
    uc_B : unitacontrollo_B 
        port map(
            init => start_B,
            clock_cu_B => clk_B,
            rst_cu_B => rst_B,
            read_B => temp_rd,
            write_B => temp_wrt,
            count => temp_cnt,
            en_ctr => temp_en_ctr,
            accepted => accepted_B,
            data_ready => data_ready_B,
            somma => temp_somma
            --X => X_B,
            --Y => temp_Y,
            --Z => temp_Z
        );

    uo_B : unita_operativa_B
        port map(
            clk_uo_B => clk_B,
            rst_uo_B => rst_B,
            en_ctr_uo_B => temp_en_ctr,
            rd_uo_B => temp_rd,
            wrt_uo_B => temp_wrt,
            X_uo_B => X_B,
            cnt_uo_B => temp_cnt,
            somma_uo_B => temp_somma
            --Y_uo_B => temp_Y,
            --Z_uo_B => Z_B
        );

end structural;
