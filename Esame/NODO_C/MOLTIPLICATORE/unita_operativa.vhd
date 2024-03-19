library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity unita_operativa is
    port( X, Y: in std_logic_vector(3 downto 0);
          clock, reset: in std_logic;
          loadAQ, shift, loadM, sub, selAQ, count_in: in std_logic;
          count: out std_logic_vector(1 downto 0);
          P: out std_logic_vector(7 downto 0));
end unita_operativa;

architecture structural of unita_operativa is
	
    component adder_sub is
        port( X, Y: in std_logic_vector(3 downto 0);
              cin: in std_logic;
              Z: out std_logic_vector(3 downto 0);
              cout: out std_logic
            );		  
    end component;
    
    component registro4 is 
        port( A: in std_logic_vector(3 downto 0);
              clk, res, load: in std_logic;
              B: out std_logic_vector(3 downto 0)
            );
    end component;
    
    
    component mux_21 is
        generic (width : integer range 0 to 17 := 8);
        port( x0, x1: in std_logic_vector(width-1 downto 0); 
              s: in std_logic;
              y: out std_logic_vector(width-1 downto 0)
            );
    end component;
    
    
    component shift_register is
        port( parallel_in: in std_logic_vector(8 downto 0);
              serial_in: in std_logic;
              clock, reset, load, shift: in std_logic;
              parallel_out: out std_logic_vector(8 downto 0)
            );	  
    end component;

    
    component cont_mod4 is
        port( clock,  reset: in std_logic;
              count_in: in std_logic;
              count: out std_logic_vector(1 downto 0));
    end component;

    signal Mreg: std_logic_vector(3 downto 0); 
    signal AQ_init: std_logic_vector(8 downto 0); 
    signal AQ_in: std_logic_vector(8 downto 0); 
    signal AQ_out: std_logic_vector(8 downto 0);
    signal partial: std_logic_vector(3 downto 0); 
    signal AQ_sum_in : std_logic_vector(8 downto 0); 
    signal riporto: std_logic;
    signal SRserialIn: std_logic;
	
begin
	
    M: registro8 port map(Y, clock, reset, loadM, Mreg);
    
    AQ_init <= "0000" & X & "0"; 
    
    AQ_sum_in <= partial & AQ_out(8 downto 0); 
    
    MUX_SR_parallel_in : mux_21 generic map (width => 9) port map(AQ_init, AQ_sum_in, selAQ, AQ_in); 
    
    SRserialIn <= AQ_out(8); 
    	
    SR: shift_register port map(AQ_in, SRserialIn, clock, reset, loadAQ, shift, AQ_out);
	
    ADD_SUB: adder_sub port map(AQ_out(8 downto 5), Mreg, sub, partial, riporto); --
	
    CONT: cont_mod4 port map(clock, reset, count_in, count);
	
    P <= AQ_out;
	
end structural;