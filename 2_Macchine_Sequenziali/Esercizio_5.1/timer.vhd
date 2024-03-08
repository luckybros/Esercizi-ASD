library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
use work.all;

entity timer is 
    port(   
        clk, rst : in std_logic;
        start : in std_logic;
        load_s, load_min, load_h : in std_logic;
        set_s, set_min : in std_logic_vector(5 downto 0);
        set_h : in std_logic_vector(4 downto 0);     
        secondi, minuti : out std_logic_vector(5 downto 0);
        ore : out std_logic_vector(4 downto 0)   
    );
end timer;

architecture structural of timer is

    component cont_mod_n is
        generic(
            N : positive := 2;
            max : positive := 60
        );
        port( load : in std_logic;
            init : in std_logic_vector(N-1 downto 0);
            clock, reset: in std_logic;
            count_in: in std_logic;
            count: out std_logic_vector(N-1 downto 0);
            y : out std_logic
        );
    end component;

    signal temp_en_min : std_logic;
    signal temp_en_h : std_logic;
    signal temp_uscita : std_logic;

    begin 
        counter_sec : cont_mod_n
            generic map(6, 60)
            port map( 
                load => load_s,
                init => set_s,
                clock => clk,
                reset => rst,
                count_in => start,
                count => secondi,
                y => temp_en_min
            );
    
        counter_min : cont_mod_n
            generic map(6, 60)
            port map( 
                load => load_min,
                init => set_min,
                clock => clk,
                reset => rst,
                count_in => temp_en_min,
                count => minuti,
                y => temp_en_h
            );
    
        counter_h : cont_mod_n
            generic map(5, 24)
            port map( 
                load => load_h,
                init => set_h,
                clock => clk,
                reset => rst,
                count_in => temp_en_h,
                count => ore,
                y => temp_uscita
        );
    
end structural;