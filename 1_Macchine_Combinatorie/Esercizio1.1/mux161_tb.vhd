library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux161_tb is
end mux161_tb;

architecture behavioural of mux161_tb is
    component mux161 is 
        port(  c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, 
            c14, c15, s0, s1, s2, s3 : in STD_LOGIC;
            y1 : out STD_LOGIC
        );
    end component;

    signal datain : STD_LOGIC_VECTOR(15 downto 0) := (others => 'U');
    signal selection : STD_LOGIC_VECTOR(3 downto 0) := (others => 'U');
    signal dataout : STD_LOGIC := 'U';

    begin
        uut : mux161
        port map(
            c0 => datain(0),
            c1 => datain(1),
            c2 => datain(2),
            c3 => datain(3),
            c4 => datain(4),
            c5 => datain(5),
            c6 => datain(6),
            c7 => datain(7),
            c8 => datain(8),
            c9 => datain(9),
            c10 => datain(10),
            c11 => datain(11),
            c12 => datain(12),
            c13 => datain(13),
            c14 => datain(14),
            c15 => datain(15),
            s0 => selection(0),
            s1 => selection(1),
            s2 => selection(2),
            s3 => selection(3),
            y1 => dataout
        );

        stim_proc : process
        begin
            wait for 10 ns;
            datain <= "1000110110110010";
            wait for 10 ns;
            selection <= "0000";
            wait for 5 ns;
            selection <= "0011";
            wait for 5 ns;
            selection <= "0100";
            wait for 5 ns;
            selection <= "0111";
            --assert dataout = '1'
            --report "errore"
            --severity failure;
            wait;
        end process;


end behavioural;
