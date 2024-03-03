library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity sistema_totale is
    port(
        clk: in std_logic;
        rst: in std_logic;
        start: in std_logic;
        out_sis: out std_logic_vector(3 downto 0);
        ending: out std_logic
    );
end sistema_totale;

architecture structural of sistema_totale is
    signal start_pulito: std_logic;
    signal rst_pulito: std_logic;

    component PO_PC is
        port (
            clock : in std_logic;
            reset : in std_logic;
            inizio : in std_logic;
            uscita : out std_logic_vector(3 downto 0);
            fine : out std_logic
        );
    end component;

    component ButtonDebouncer is
        generic (                       
            CLK_period: integer := 10;  -- periodo del clock (della board) in nanosecondi
            btn_noise_time: integer := 10000000 -- durata stimata dell'oscillazione del bottone in nanosecondi
                                                -- il valore di default Ã¨ 10 millisecondi
        );
        Port ( RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               BTN : in STD_LOGIC;
               CLEARED_BTN : out STD_LOGIC);
    end component;

    begin
        popc: PO_PC 
        port map(
            clock => clk,
            reset => rst_pulito,
            inizio => start_pulito,
            uscita => out_sis,
            fine => ending
        );

        dbs: ButtonDebouncer
        generic map (                       
            CLK_period => 10,
            btn_noise_time => 10000000 
        )
        port map(
            RST => '0',
            CLK => clk, 
            BTN => start,
            CLEARED_BTN => start_pulito
        );

        dbr: ButtonDebouncer
        generic map (                       
            CLK_period => 10,
            btn_noise_time => 10000000 
        )
        port map(
            RST => '0',
            CLK => clk, 
            BTN => rst,
            CLEARED_BTN => rst_pulito
        );
    end structural;