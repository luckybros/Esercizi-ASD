library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity riconoscitore_sequenza_tb is
end riconoscitore_sequenza_tb;

architecture rtl of riconoscitore_sequenza_tb is
    component riconoscitore_sequenza
        port(   i : in STD_LOGIC;
                m : in STD_LOGIC;
                a : in STD_LOGIC;
                y : out STD_LOGIC
        );
    end component;

    signal datain : STD_LOGIC := 'U';
    signal mode : STD_LOGIC := 'U';
    signal timing : STD_LOGIC := 'U';
    signal dataout : STD_LOGIC := 'U';

    begin
        dut : riconoscitore_sequenza
        port map(
            i => datain,
            m => mode,
            a => timing,
            y => dataout
        );

        stim_proc : process
        begin 
            -- m = 1 parzialmente sovrapposta.
            mode <= '1';
            timing <= '0';
            wait for 5 ns;
            timing <= '1';
            wait for 5 ns;
            timing <= '0'; -- non ho compreso bene questa parte iniziale.

            wait for 5 ns;
            datain <= '0';
            wait for 5 ns;
            timing <= '1';
            wait for 5 ns;
            timing <= '0';
            wait for 5 ns;
            datain <= '1';
            wait for 5 ns;
            timing <= '1';
            wait for 5 ns;
            timing <= '0';
            wait for 5 ns;
            datain <= '1'; 
            wait for 5 ns;
            timing <= '1';
            wait for 5 ns;
            timing <= '0';
            wait for 5 ns;
            datain <= '0';
            wait for 5 ns;
            timing <= '1';
            wait for 5 ns;
            timing <= '0';
            wait for 5 ns;
            datain <= '1'; 
            wait for 5 ns;
            timing <= '1';
            wait for 5 ns;
            timing <= '0';
            wait for 10 ns;--01101

            -- m = 0 non sovrapposto.
            mode <= '0'; 
            timing <= '0';
            --wait for 5 ns;
            --timing <= '1';
            --wait for 5 ns;
            --timing <= '0'; -- non ho compreso bene questa parte iniziale.

            wait for 5 ns;
            datain <= '0'; 
            wait for 5 ns;
            timing <= '1';
            wait for 5 ns;
            timing <= '0';
            wait for 5 ns;
            datain <= '1'; 
            wait for 5 ns;
            timing <= '1';
            wait for 5 ns;
            timing <= '0';
            wait for 5 ns;
            datain <= '0'; 
            wait for 5 ns;
            timing <= '1';
            wait for 5 ns;
            timing <= '0';
            wait for 5 ns;
            datain <= '1'; 
            wait for 5 ns;
            timing <= '1';
            wait for 5 ns;
            timing <= '0';
            wait for 5 ns;
            datain <= '0'; 
            wait for 5 ns;
            timing <= '1';
            wait for 5 ns;
            timing <= '0';
            wait for 5 ns;
            datain <= '1'; 
            wait for 5 ns;
            timing <= '1';
            wait for 5 ns;
            timing <= '0';
            wait for 5 ns;
            datain <= '0'; 
            wait for 5 ns;
            timing <= '1';
            wait for 5 ns;
            timing <= '0';
            wait for 5 ns;
            datain <= '1'; 
            wait for 5 ns;
            timing <= '1';
            wait for 5 ns;
            timing <= '0';
            wait for 5 ns;
            datain <= '0'; 
            wait for 5 ns;
            timing <= '1';
            wait for 5 ns;
            timing <= '0';
            wait for 10 ns;--010101010
            

            wait;

        end process;

    end rtl;


