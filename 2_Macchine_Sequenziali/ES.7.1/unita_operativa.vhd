library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity unita_operativa is
    port( X, Y: in std_logic_vector(7 downto 0);
          clock, reset: in std_logic;
          loadAQ, shift, loadM, sub, selAQ, count_in: in std_logic;
          count: out std_logic_vector(2 downto 0);
          P: out std_logic_vector(16 downto 0));
end unita_operativa;

architecture structural of unita_operativa is
	
    component adder_sub is
        port( X, Y: in std_logic_vector(7 downto 0);
              cin: in std_logic;
              Z: out std_logic_vector(7 downto 0);
              cout: out std_logic);		  
    end component;
    
    component registro8 is 
        port( A: in std_logic_vector(7 downto 0);
              clk, res, load: in std_logic;
              B: out std_logic_vector(7 downto 0));
    end component;
    
    
    component mux_21 is
        generic (width : integer range 0 to 17 := 8);
        port( x0, x1: in std_logic_vector(width-1 downto 0); 
              s: in std_logic;
              y: out std_logic_vector(width-1 downto 0));
    end component;
    
    
    component shift_register is
        port( parallel_in: in std_logic_vector(16 downto 0);
              serial_in: in std_logic;
              clock, reset, load, shift: in std_logic;
              parallel_out: out std_logic_vector(16 downto 0));	  
    end component;

	-- non lo consideriamo più di 16 in quanto adesso dobbiamo
	-- mantenere anche q(-1).
    
    component cont_mod8 is
        port( clock,  reset: in std_logic;
              count_in: in std_logic;
              count: out std_logic_vector(2 downto 0));
    end component;

    signal Mreg: std_logic_vector(7 downto 0); -- collegamento 
	--tra il registro del moltiplicando e l'addizionatore/sottrattore.
    signal AQ_init: std_logic_vector(16 downto 0); -- serve ad inizializzare 
	--lo shift register.
    signal AQ_in: std_logic_vector(16 downto 0); -- collega l'uscita del MUX all'ingresso shift register.
    signal AQ_out: std_logic_vector(16 downto 0); -- contenuto di AQ.
    signal partial: std_logic_vector(7 downto 0); -- somma parziale.
    signal AQ_sum_in : std_logic_vector(16 downto 0); -- cosa mettiamo in AQ dopo la somma. 
    signal riporto: std_logic;
    signal SRserialIn: std_logic; -- ingresso dello shift.
	
begin
	
    M: registro8 port map(Y, clock, reset, loadM, Mreg);
    
    AQ_init <= "00000000" & X & "0"; --tutti 0.
    
    AQ_sum_in <= partial & AQ_out(8 downto 0); -- somma parziale concatenata a quello che c'è in Q.
    
    MUX_SR_parallel_in : mux_21 generic map (width => 17) port map(AQ_init, AQ_sum_in, selAQ, AQ_in); -- sceglie se
	--inizializzare AQ a 0 o inserire la somma parziale.
    
    SRserialIn <= AQ_out(16); -- il bit più significativo verrà inserito in testa allo shift.
    	
    SR: shift_register port map(AQ_in, SRserialIn, clock, reset, loadAQ, shift, AQ_out);
	
    ADD_SUB: adder_sub port map(AQ_out(16 downto 9), Mreg, sub, partial, riporto); -- solo ciò che è
	--presente in A verrà sommato. 
	
    CONT: cont_mod8 port map(clock, reset, count_in, count);
	
    P <= AQ_out;
	
end structural;
