library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cont_mod_n is
	generic(
		N : positive := 2;
		max : positive := 60
	);
	port( load: in std_logic;
		  init : in std_logic_vector(N-1 downto 0);
		  clock, reset: in std_logic;
	      count_in: in std_logic;
		  count: out std_logic_vector(N-1 downto 0);
		  y : out std_logic
		);
end cont_mod_n;

architecture behavioural of cont_mod_n is
	signal c: std_logic_vector(N downto 0) := (others=>'0');
	signal temp_end : std_logic := '0';
	
	begin	
	CM8: process(clock)
	begin
		
		if(load = '1') then 
			c(N-1 downto 0) <= init;
		end if;
		
		if(rising_edge(clock)) then 
			if(temp_end = '1') then
				temp_end <= '0';
			end if;
		   	if(reset = '1') then 
			   c <= (others=>'0');
		   	else 
		       	if(count_in = '1') then
			    	c <= std_logic_vector(unsigned(c) + 1); -- rende c unsigned, lo incrementa e lo trasforma in vettore
					if(c = std_logic_vector(to_unsigned(max, c'length))) then
						c <= (others => '0');
						temp_end <= '1';
				  	end if;
		       	end if;
			end if;
		end if;
	end process;
	
	count <= c(N-1 downto 0);
	y <= temp_end;
	
end behavioural;