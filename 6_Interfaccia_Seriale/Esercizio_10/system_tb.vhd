library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity system_tb is
-- Testbench doesn't have ports.
end system_tb;

architecture tb of system_tb is
    -- Signals corresponding to system's ports
    signal tb_sys_start, tb_sys_clock, tb_sys_reset : std_logic := '0';

    -- Component declaration for the system
    component system is
        port(
            sys_start, sys_clock, sys_reset : in std_logic
        );
    end component;

begin
    -- Instance of the system
    uut: system
        port map(
            sys_start => tb_sys_start,
            sys_clock => tb_sys_clock,
            sys_reset => tb_sys_reset
        );

    -- Clock generation
    clock_gen: process
    begin
        while true loop
            tb_sys_clock <= '0';
            wait for 5 ns; -- Adjust the clock period according to your design requirements
            tb_sys_clock <= '1';
            wait for 5 ns;
        end loop;
    end process;

    -- Reset process
    reset_gen: process
    begin
        tb_sys_reset <= '1';
        wait for 20 ns; -- Adjust the reset duration according to your design requirements
        tb_sys_reset <= '0';
        wait;
    end process;

    -- Stimulus process
    stimulus_proc: process
    begin
        -- Initial state
        tb_sys_start <= '0';
        wait for 100 ns; -- Wait for system to stabilize

        -- Test case 1: Start signal
        tb_sys_start <= '1';
        wait for 5000 ns;
        --tb_sys_start <= '0';

        -- Add more test cases as required to fully exercise the system

        wait; -- Terminate the simulation
    end process;

end tb;