library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity s_system_tb is
end s_system_tb;

architecture behavioural of s_system_tb is
    component s_system is
        port(   in_system : in STD_LOGIC_VECTOR(3 downto 0);
                out_system : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal datain : STD_LOGIC_VECTOR(3 downto 0) := (others => 'U');
    signal dataout : STD_LOGIC_VECTOR(3 downto 0) := (others => 'U');

    begin
        dut : s_system
        port map(
            in_system => datain,
            out_system => dataout
        );

        stim_proc : process
        begin 
            wait for 10 ns;
            datain <= "0011"; -- prendiamo 10001000 che verrà trasformato in 1111.
            wait for 10 ns;
            wait;
        end process;

end behavioural;
