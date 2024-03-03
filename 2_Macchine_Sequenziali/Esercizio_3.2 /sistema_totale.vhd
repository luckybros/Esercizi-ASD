library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity sistema is
    port(
        ingresso : in std_logic;
        modalita : in std_logic;
        abilitazione : in std_logic;
        bottone_i : in std_logic;
        bottone_m : in std_logic;
        risultato: out std_logic
    );
end sistema;

architecture structural of sistema is
    signal m_pulito: std_logic;
    signal i_pulito: std_logic;

    component riconoscitore_sequenza is
        port(   i : in STD_LOGIC;
                m : in STD_LOGIC;
                a : in STD_LOGIC;
                button_i: in STD_LOGIC;
                button_m: in STD_LOGIC;
                y : out STD_LOGIC
        );
    end component;

    component ButtonDebouncer is
        generic (                       
            CLK_period: integer := 10;  
            btn_noise_time: integer := 10000000
        );
        Port ( RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               BTN : in STD_LOGIC;
               CLEARED_BTN : out STD_LOGIC);
    end component;

    begin
        rico: riconoscitore_sequenza 
        port map(
            i => ingresso,
            m => modalita,
            a => abilitazione,
            button_i => i_pulito,
            button_m => m_pulito,
            y => risultato
        );

        bdi: ButtonDebouncer
        Generic map ( 
            CLK_period => 10,  -- Period of the board's clock in 10ns
            btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
        )
        port map(
            RST => '0',
            CLK => abilitazione, 
            BTN => bottone_i,
            CLEARED_BTN => i_pulito
        );

        bdm: ButtonDebouncer
        Generic map ( 
            CLK_period => 10,  -- Period of the board's clock in 10ns
            btn_noise_time => 10000000 -- Estimated button bounce duration of 10ms
        )
        port map(
            RST => '0',
            CLK => abilitazione, 
            BTN => bottone_m,
            CLEARED_BTN => m_pulito
        );
    end structural;