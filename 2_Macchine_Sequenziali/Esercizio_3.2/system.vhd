library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity system is
    port (  s1 : in std_logic;
            s2 : in std_logic;
            b1 : in std_logic;
            b2 : in std_logic;
            clock100MHZ : in std_logic;
            uscita : out std_logic
    );
end system;

architecture structural of system is
    signal data_in : std_logic;
    signal mode : std_logic;
    signal cleared_b1 : std_logic;
    signal cleared_b2 : std_logic;

    component ButtonDebouncer is
        generic (                       
            CLK_period: integer := 10;  -- periodo del clock (della board) in nanosecondi
            btn_noise_time: integer := 10000000 -- durata stimata dell'oscillazione del bottone in nanosecondi
                                                -- il valore di default è 10 millisecondi
        );
        Port ( RST : in STD_LOGIC;
               CLK : in STD_LOGIC;
               BTN : in STD_LOGIC;
               CLEARED_BTN : out STD_LOGIC);
    end component;

    component unita_di_controllo is 
        port(   switch_in_1 : in std_logic;
                switch_in_2 : in std_logic;
                button_1 : in std_logic;
                button_2 : in std_logic;
                clk_cu : in std_logic;
                switch_out_data : out std_logic;
                switch_out_mode : out std_logic
    );
    end component;

    component riconoscitore_sequenza is
        port(   i : in STD_LOGIC;
                m : in STD_LOGIC;
                a : in STD_LOGIC;
                y : out STD_LOGIC
        );
    end component;

    begin
        debouncer_1 : ButtonDebouncer
        port map(   RST => '0',
                    CLK => clock100MHZ,
                    BTN => b1, 
                    CLEARED_BTN => cleared_b1
        );
        
        debouncer_2 : ButtonDebouncer
        port map(   RST => '0',
                    CLK => clock100MHZ,
                    BTN => b2, 
                    CLEARED_BTN => cleared_b2
        );

        unita : unita_di_controllo
        port map(   switch_in_1 => s1,
                    switch_in_2 => s2,
                    button_1 => cleared_b1,
                    button_2 => cleared_b2,
                    clk_cu => clock100MHZ,
                    switch_out_data => data_in,
                    switch_out_mode => mode
        );

        rico : riconoscitore_sequenza
        port map(   i => data_in,
                    m => mode,
                    a => clock100MHZ,
                    y => uscita
        );

end structural;

