library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity molt_booth_tb is
end molt_booth_tb;

architecture behavioural of molt_booth_tb is

	component molt_booth is
	  port( clock, reset, start: in std_logic;
		   X, Y: in std_logic_vector(7 downto 0);	   
		   product: out std_logic_vector(15 downto 0);
		   stop_cu: out std_logic);
	end component;

	signal inputx, inputy: std_logic_vector(7 downto 0);
	signal prod: std_logic_vector(15 downto 0);
	signal clk, res, start: std_logic;
	signal t_stop_cu: std_logic;
    constant clk_period : time := 20 ns;
    
    signal end_sim : std_logic := '0';
    
       
	begin
	
	uut: molt_booth port map(clk, res, start, inputx, inputy, prod, t_stop_cu);
	
	clk_process : process
     begin
        while (end_sim = '0') loop
            clk<= '1';
            wait for clk_period/2;
            clk <= '0';
            wait for clk_period/2;
        end loop;
        wait;
     end process;
	
	sim: process
		begin
		 
			wait for 100 ns;
		
			res<='1';
			wait for 20 ns;
			res<='0';
			wait for 10 ns;
			inputx<="00001111";  -- 15*3=45 (002D)
			inputy<="00000011";  
			wait for 40 ns;
			start<='1';
			wait for 20 ns;
			start<='0';
			wait for 10 ns;
			wait;
		end process;
	
	
	end behavioural;