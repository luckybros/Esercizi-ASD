library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity tb_system is
end tb_system;

architecture testbench of tb_system is

    signal start_tb : std_logic := '0';
    signal clock_tb : std_logic := '0';
    signal reset_tb : std_logic := '0';

    constant clock_period : time := 10 ns; -- Adjust as needed

    component system
        port(
            start : in std_logic;
            clock : in std_logic;
            reset : in std_logic
            --data_out : out std_logic_vector(7 downto 0)
        );
    end component;

    begin
        uut_system : system
            port map(
                start => start_tb,
                clock => clock_tb,
                reset => reset_tb
            );

    process
    begin
        while now < 1000 ns
            loop
                clock_tb <= not clock_tb;
                wait for clock_period / 2;
            end loop;
        wait;
    end process;

    -- Stimulus process
    process
    begin
        reset_tb <= '1';
        wait for 10 ns;
        reset_tb <= '0';
        wait for 10 ns; 
        start_tb <= '1'; 
        wait for 500 ns; 
        start_tb <= '0'; 
        wait for 100 ns; 
        reset_tb <= '1';
        wait for 10 ns;
        wait;
    end process;
    end architecture;

