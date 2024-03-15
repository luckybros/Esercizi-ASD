library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity system is
    port(   clock_system, reset_system, start_system: in std_logic;
            X_system, Y_system: in std_logic_vector(7 downto 0);		   
            product_system: out std_logic_vector(15 downto 0);
            stop_cu_system: out std_logic);
end system; 

architecture structural of system is

    signal reset_n : std_logic;
    signal start_n : std_logic;

    begin 

        debouncer_start : entity work.ButtonDebouncer
        generic map(    CLK_period => 10, 
                        btn_noise_time => 10000000)

        port map(       RST => reset_n, 
                        CLK => clock_system,    
                        BTN => start_system,
                        CLEARED_BTN => start_n 
                );
        debouncer_reset : entity work.ButtonDebouncer
        generic map(    CLK_period => 10, 
                        btn_noise_time => 10000000)
        
        port map(       RST => '0', 
                        CLK => clock_system,    
                        BTN => reset_system,
                        CLEARED_BTN => reset_n 
                );         

        molt : entity work.molt_booth
        port map(       clock => clock_system, 
                        reset => reset_system,
                        start => start_n,
                        X => X_system,
                        Y => Y_system,
                        product => product_system,
                        stop_cu => stop_cu_system
                );

end structural;
