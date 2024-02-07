library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity PO_PC_tb is
end PO_PC_tb;

architecture dataflow of PO_PC_tb is


    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal start : std_logic := '0';
    signal fine_processo : std_logic;

    constant clock_period : time := 10 ns;

    begin
        UUT: entity work.PO_PC
        port map (
            clock   => clk,
            reset   => rst,
            inizio  => start,
            fine    => fine_processo
        );


        timing_clock : process
        begin
            while now < 1000 ns loop
                clk <= not clk;
                wait for clock_period / 2;
            end loop;
            wait;
        end process;

        process
        begin
            rst <= '1';
            start <= '0';
            wait for 10 ns;

            rst <= '0';
            wait for 10 ns;

            start <= '1';
            wait for 50 ns;

            start <= '0';
            wait for 50 ns;
            wait;
        end process;

end dataflow;