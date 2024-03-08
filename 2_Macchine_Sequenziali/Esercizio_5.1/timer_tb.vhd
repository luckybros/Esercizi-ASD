LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY timer_tb IS
END timer_tb;

ARCHITECTURE behavior OF timer_tb IS 

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT timer
    PORT(
        clk, rst : IN  std_logic;
        start : IN  std_logic;
        load_s, load_min, load_h : IN  std_logic;
        set_s, set_min : IN  std_logic_vector(5 DOWNTO 0);
        set_h : IN  std_logic_vector(4 DOWNTO 0);     
        secondi, minuti : OUT  std_logic_vector(5 DOWNTO 0);
        ore : OUT  std_logic_vector(4 DOWNTO 0)
    );
    END COMPONENT;
   
    --Inputs
    signal clk, rst : std_logic := '0';
    signal start : std_logic := '0';
    signal load_s, load_min, load_h : std_logic := '0';
    signal set_s, set_min : std_logic_vector(5 DOWNTO 0) := (others => '0');
    signal set_h : std_logic_vector(4 DOWNTO 0) := (others => '0');

    --Outputs
    signal secondi, minuti : std_logic_vector(5 DOWNTO 0);
    signal ore : std_logic_vector(4 DOWNTO 0);

    -- Clock period definitions
    constant clk_period : time := 10 ns;

BEGIN

    -- Instantiate the Unit Under Test (UUT)
    uut: timer PORT MAP (
        clk => clk,
        rst => rst,
        start => start,
        load_s => load_s,
        load_min => load_min,
        load_h => load_h,
        set_s => set_s,
        set_min => set_min,
        set_h => set_h,
        secondi => secondi,
        minuti => minuti,
        ore => ore
    );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin       
        -- initialization
        rst <= '1';
        wait for clk_period*10;
        rst <= '0';
        wait for clk_period*10;
        
        -- Test: Set and start timer
        load_s <= '1';
        load_min <= '1';
        load_h <= '1';
        set_s <= "001010"; -- 10 seconds
        set_min <= "000011"; -- 3 minutes
        set_h <= "00010"; -- 2 hours
        wait for clk_period*2;
        load_s <= '0';
        load_min <= '0';
        load_h <= '0';
        start <= '1';
        
        -- Simulate for 200 ns
        wait for 200 ns;
        
        -- Add more stimulus here

        wait;
    end process;

END behavior;