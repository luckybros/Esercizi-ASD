library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity omega_network_tb is
-- Testbench has no ports.
end omega_network_tb;

architecture tb of omega_network_tb is
    -- Component declaration for the UUT (Unit Under Test)
    component omega_network
        port(
            abilitazione : in STD_LOGIC_VECTOR(3 downto 0);
            ing0 : in STD_LOGIC_VECTOR(2 downto 0);
            ing1 : in STD_LOGIC_VECTOR(2 downto 0);
            ing2 : in STD_LOGIC_VECTOR(2 downto 0);
            ing3 : in STD_LOGIC_VECTOR(2 downto 0);
            uscita_sistema : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    -- Signals for interfacing with UUT
    signal abilitazione : STD_LOGIC_VECTOR(3 downto 0);
    signal ing0, ing1, ing2, ing3 : STD_LOGIC_VECTOR(2 downto 0);
    signal uscita_sistema : STD_LOGIC_VECTOR(3 downto 0);

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: omega_network
        port map (
            abilitazione => abilitazione,
            ing0 => ing0,
            ing1 => ing1,
            ing2 => ing2,
            ing3 => ing3,
            uscita_sistema => uscita_sistema
        );

    -- Stimulus process
    stimulus: process
    begin
        -- Scenario 1: Test with initial inputs
        abilitazione <= "0001";
        ing0 <= "101";
        ing1 <= "010";
        ing2 <= "111";
        ing3 <= "001";
        wait for 10 ns;

        -- Scenario 2: Test with different inputs
        abilitazione <= "1010";
        ing0 <= "011";
        ing1 <= "100";
        ing2 <= "001";
        ing3 <= "110";
        wait for 10 ns;
        wait;
    end process;

end tb;
