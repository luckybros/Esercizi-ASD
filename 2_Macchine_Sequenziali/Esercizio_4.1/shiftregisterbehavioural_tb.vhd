library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity tb_shiftregisterbehavioural is
end tb_shiftregisterbehavioural;

architecture testbench of tb_shiftregisterbehavioural is
    signal datain, clock, reset : STD_LOGIC := '0';
    signal scelta : STD_LOGIC := '0';  -- Modifica in STD_LOGIC
    signal shift : STD_LOGIC_VECTOR(1 downto 0) := "01";  -- Modifica in STD_LOGIC_VECTOR
    signal lucario : STD_LOGIC_VECTOR(7 downto 0);
    signal dataout : STD_LOGIC;

    constant CLK_PERIOD : time := 100 ns;

    component shiftregisterbehavioural
        generic (
            N : integer := 8
        );
        port (
            EI, ck, rst : in STD_LOGIC;
            choice : in STD_LOGIC; -- Modifica in STD_LOGIC
            y : in STD_LOGIC_VECTOR(1 downto 0);  -- Modifica in STD_LOGIC_VECTOR
            memo : out STD_LOGIC_VECTOR(N-1 downto 0);
            EO : out STD_LOGIC
        );
    end component;

begin
    -- Instantiate the shift register behavioral module
    DUT: shiftregisterbehavioural
        generic map (
            N => 8
        )
        port map (
            EI => datain,
            ck => clock,
            rst => reset,
            choice => scelta,
            y => shift,
            memo => lucario,
            EO => dataout
        );

    process
    begin
        clock <= '0';
        wait for CLK_PERIOD / 2;
        clock <= '1';
        wait for CLK_PERIOD / 2;
    end process;

    process
    begin
        reset <= '1';
        datain <= '1';
        scelta <= '0';  -- Modifica in STD_LOGIC
        shift <= "01";  -- Modifica in STD_LOGIC_VECTOR
        wait for 3*CLK_PERIOD / 2;

        reset <= '0';
        wait for 3*CLK_PERIOD / 2;

        -- shift a destra di 1.
        scelta <= '0';  -- Modifica in STD_LOGIC
        shift <= "01";  -- Modifica in STD_LOGIC_VECTOR
        wait for 3*CLK_PERIOD / 2;

        -- shift a sinistra di 2.
        datain <= '0';
        scelta <= '1';  -- Modifica in STD_LOGIC
        shift <= "10";  -- Modifica in STD_LOGIC_VECTOR
        wait for 3*CLK_PERIOD / 2;

        --shift a destra di 1.
        datain <= '0';
        scelta <= '0';  -- Modifica in STD_LOGIC
        shift <= "01";  -- Modifica in STD_LOGIC_VECTOR
        wait for 3*CLK_PERIOD / 2;

        wait;
    end process;

end testbench;



-- 0 shift destra.
-- 1 shift sinistra.

