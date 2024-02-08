library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
use work.all;

entity shiftregisterstructural_tb is
    end shiftregisterstructural_tb;

architecture testbench of shiftregisterstructural_tb is
    signal clk, rst, datain : std_logic := '0';
    signal sel : std_logic_vector(1 downto 0) := "00";
    signal dataout : std_logic_vector(7 downto 0);

    component shiftregisterstructural
        generic (
            n : integer := 8
        );
        port (
            ei, clock, reset: in std_logic;
            selection : in std_logic_vector(1 downto 0);
            eo : out std_logic_vector(n-1 downto 0)
        );
    end component;

begin
    dut: shiftregisterstructural
        port map (
            ei => datain,
            clock => clk,
            reset => rst,
            selection => sel,
            eo => dataout
        );

    clock_process: process
    begin
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end process clock_process;

    stimulus_process: process
    begin
        rst <= '1'; -- Reset attivo basso
        wait for 10 ns;
        rst <= '0'; -- Rilascia il reset
        wait for 10 ns;

        -- Esempio di sequenza di input
        datain <= '1'; 
        sel <= "00"; 
        wait for 10 ns;

        datain <= '0'; 
        sel <= "01"; 
        wait for 10 ns;

        datain <= '1'; 
        sel <= "10"; 
        wait for 10 ns;

        datain <= '0'; 
        sel <= "11"; 
        wait for 10 ns;

        datain <= '1'; 
        sel <= "00"; 
        wait for 10 ns;

        wait;
    end process stimulus_process;

end testbench;