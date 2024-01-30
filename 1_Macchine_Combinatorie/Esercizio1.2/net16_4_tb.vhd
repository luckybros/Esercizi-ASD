library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity net16_4_tb is
end net16_4_tb;

architecture behavioural of net16_4_tb is
    component net16_4 is
        port(   net16_4_a : in STD_LOGIC_VECTOR(15 downto 0);
                net16_4_s_mux : in STD_LOGIC_VECTOR(3 downto 0);
                net16_4_s_demux : in STD_LOGIC_VECTOR(1 downto 0);
                net16_4_y : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    signal datain : STD_LOGIC_VECTOR(15 downto 0) := (others => 'U');
    signal selection_mux : STD_LOGIC_VECTOR(3 downto 0) := (others => 'U');
    signal selection_demux : STD_LOGIC_VECTOR(1 downto 0) := (others => 'U');
    signal dataout : STD_LOGIC_VECTOR(3 downto 0) := (others => 'U');

begin
    dut : net16_4
    port map(
        net16_4_a => datain,
        net16_4_s_mux => selection_mux,
        net16_4_s_demux => selection_demux,
        net16_4_y => dataout
    );

    stim_proc : process
    begin 
        wait for 10 ns;
        datain <= "1001000100001001";
        wait for 10 ns;
        selection_mux <= "0011"; -- il terzo bit che vale 1.
        wait for 10 ns;
        selection_demux <= "01"; -- esce 2 sul primo filo.
        wait for 10 ns;
        wait;
    end process;

end behavioural;
