library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity molt_booth is
	 port( clock, reset, start: in std_logic;
		   X, Y: in std_logic_vector(3 downto 0);		   
		   product: out std_logic_vector(7 downto 0);
		   stop_cu: out std_logic);
end molt_booth;

architecture structural of molt_booth is
	component unita_controllo is 
		port( q : in std_logic_vector(1 downto 0);
		  clock, reset, start: in std_logic;
		  count: in std_logic_vector(1 downto 0);
		  loadM, count_in, loadAQ, en_shift: out std_logic;
		  selAQ, subtract, stop_cu: out std_logic); 
	end component;
	
	component unita_operativa is
	port( X, Y: in std_logic_vector(3 downto 0);
		  clock, reset: in std_logic;
		  loadAQ, shift, loadM, sub, selAQ, count_in: in std_logic;
		  count: out std_logic_vector(1 downto 0);
		  P: out std_logic_vector(7 downto 0));
	end component;
	
	
	signal tempq : std_logic_vector(1 downto 0);
	signal temp_selAQ, temp_sub, temp_loadAQ: std_logic;
	signal temp_count: std_logic_vector(1 downto 0);
	signal temp_p: std_logic_vector(7 downto 0);
	signal temp_count_in : std_logic;
	signal temp_shift: std_logic;
	signal temp_loadM: std_logic;
	
	begin
	
	UC: unita_controllo port map(
        q => tempq, 
        clock => clock, 
        reset => reset, 
        start => start, 
        count => temp_count, 
        loadM => temp_loadM, 
        count_in => temp_count_in, 
        loadAQ => temp_loadAQ, 
        en_shift => temp_shift, 
        selAQ => temp_selAQ, 
        subtract => temp_sub, 
        stop_cu => stop_cu
	);	  
	
	UO: unita_operativa port map(
        X => X, 
        Y => Y, 
        clock => clock, 
        reset => reset, 
        loadAQ => temp_loadAQ, 
        shift => temp_shift, 
        loadM => temp_loadM, 
        sub => temp_sub, 
        selAQ => temp_selAQ, 
        count_in => temp_count_in, 
        count => temp_count, 
        P => temp_p
	); 
		  
	tempq<=temp_p(1 downto 0); 
	product<=temp_p(7 downto 1);
	
end structural;