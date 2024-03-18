library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity unita_controllo is 
    port( q : in std_logic_vector(1 downto 0);
          clock, reset, start: in std_logic;
          count: in std_logic_vector(2 downto 0);
          loadM, count_in, loadAQ, en_shift: out std_logic;
          selAQ, subtract, stop_cu: out std_logic
    ); 
end unita_controllo;

architecture structural of unita_controllo is
    type state is (idle, fetch, wait_op, scan, rshift, increment, fine);
    signal current_state, next_state: state;

begin 
    reg_stato: process(clock) --processo per effettuare il cambio di stato.
    begin
        if(clock'event and clock='1') then
            if(reset='1') then 
                current_state <= idle;
            else 
                current_state <= next_state;
            end if;
        end if;
    end process;

    comb: process(current_state, start, count)
    begin
        count_in <= '0'; --inizializzazione dei segnali di input
        subtract <= '0';
        selAQ <= '0';
        loadAQ <= '0';  
        loadM <= '0';   
        stop_cu <= '0';  
        en_shift <= '0';
         
        case current_state is
            when idle =>          
                if(start = '1') then -- quando viene dato lo start 
				--possiamo prelevare gli operandi della moltiplicazione
                    next_state <= fetch;
                else 
                    next_state <= idle;
                end if;

            when fetch => 
                loadM <= '1'; -- carichiamo M ed AQ con il moltiplicando e 
				-- il prodotto parziale.
                loadAQ <= '1'; 
                next_state <= wait_op;

            when wait_op => 
                next_state <= scan;  -- attesa.   

            when scan =>  
                if(q = "01") then  -- somma + shift.
                    selAQ <= '1';
                    loadAQ <= '1'; 
                    next_state <= rshift;
                elsif(q = "10") then -- sottrazione + shift.
                    subtract <= '1';  
                    selAQ <= '1';
                    loadAQ <= '1'; 
                    next_state <= rshift;
                elsif (q = "00" or q = "11") then -- shift.
                    next_state <= rshift;
                end if;

            when rshift =>                      
                en_shift <= '1';
                if(count = "111") then -- fine conteggio quando abbiamo eseguito 
				--8 volte le operazioni.
                    next_state <= fine;
                else
                    next_state <= increment;
                end if;

            when increment => 
                count_in <= '1';
                next_state <= scan;

            when fine => 
                stop_cu <= '1'; 
                next_state <= idle;
        end case;
    end process; 
end structural;