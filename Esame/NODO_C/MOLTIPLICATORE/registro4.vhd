library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--registro parallelo-parallelo che mantiene il valore del moltiplicando Y
entity registro4 is 
	port( A: in std_logic_vector(3 downto 0);
		  clk, res, load: in std_logic;
		  B: out std_logic_vector(3 downto 0));
end registro4;

architecture behavioural of registro4 is
	signal temp_b: std_logic_vector(3 downto 0);
	begin
	
	R_PP: process(clk)
		begin
		if(rising_edge(clk)) then
		  if(res='1') then
			 temp_b<= (others=>'0');		   
		  else
		    if(load='1') then
			   temp_b<=A;
	        end if;
	      end if;
	    end if;
	end process;
	B<=temp_b;
end behavioural;
		  