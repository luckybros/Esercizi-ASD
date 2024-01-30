library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity riconoscitore_di_sequenza is
    port(   data : in STD_LOGIC;    
            clock : in STD_LOGIC;
            mode : in STD_LOGIC;
            y : out STD_LOGIC
    );
end riconoscitore_di_sequenza;

architecture behavioral of riconoscitore_di_sequenza is 

    type stato is (S0, S1, S2, S1', S2');
    signal stato_corrente : stato := stato := S0;
    signal stato_prossimo : stato;
    signal uscita_corrente : STD_LOGIC := 'U';

    combinatorio : process(data, mode)
        begin
        case mode is
            when '0' =>
                case stato_corrente is
                    when S0 => 
                        if (data = '0') then
                            stato_prossimo <= S1';
                        else
                            stato prossimo <= S1;
                        end if;
                        uscita_corrente <= '0';
                    when S1 =>
                        if (data = '0') then
                            stato_prossimo <= S2;
                        else
                            stato_prossimo <= S2';
                        end if;
                        uscita_corrente <= '0';
                    when S2 =>
                        stato_prossimo <= S0;
                        if (data = '0') then 
                            uscita_corrente <= '0';
                        else 
                            uscita_corrente <= '1';
                        end if;
                    when S1' => 
                        stato_prossimo <= S2';
                        uscita_corrente <= '0';
                    when S2' =>
                        stato_prossimo <= S0;
                        uscita_corrente <= '0';
                end case;
            when '1' =>
                case stato_corrente is 
                    when S0 =>
                        if(data = '0') then
                            stato_prossimo <= S0;
                        else    
                            stato_prossimo <= S1;
                        end if;
                        uscita_corrente <= '0';
                    when S1 =>
                        if(data = '0') then 
                            stato_prossimo <= S2;
                        else 
                            stato_prossimo <= S1;
                        end if;
                        uscita_corrente <= '0';
                    when S2;
                        if(data = '0') then
                            uscita_corrente <= '0';
                        else
                            uscita_corrente <= '1';
                        end if;
                        stato_prossimo <= S0;
                end case;
            end case;
        end process;  
        
    tempificazione : process(clock)
        begin
            if(clock'event and clock = '1') then
                stato_corrente <= stato_prossimo;
                y <= uscita_corrente;
            end if;
        end process;

end behavioral;
