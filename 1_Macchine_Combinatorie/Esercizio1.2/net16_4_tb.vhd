library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity net16_4_tb is
end net16_4_tb;

architecture behavioural of net16_4_tb is
    component net16_4 is
        port(   a : in STD_LOGIC_VECTOR(15 downto 0);
                s_mux : in STD_LOGIC_VECTOR(3 downto 0);
                s_demux : in STD_LOGIC_VECTOR(1 downto 0);
                y : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal datain : STD_LOGIC_VECTOR(15 downto 0) := (others => 'U');
    signal selection_mux : STD_LOGIC_VECTOR(3 downto 0) := (others => 'U');
    signal selection_demux : STD_LOGIC_VECTOR(1 downto 0) := (others => 'U');
    signal dataout : STD_LOGIC_VECTOR(3 downto 0) := (others => 'U');

    begin
        uut : net16_4
        port map(
            a => datain,
            s_mux => selection_mux,
            s_demux => selection_demux,
            y => dataout
        );

        stim_proc : process
        begin 
            wait for 10 ns;
            datain <= "1001000100001001";
            wait for 10 ns;
            selection_mux <= "0011"; -- il terzo bit che vale 1.
            wait for 10 ns;
            selection_demux <= "00"; -- esce 1 sul primo filo.
            wait for 10 ns;
            wait;
        end process;

end behavioural;
