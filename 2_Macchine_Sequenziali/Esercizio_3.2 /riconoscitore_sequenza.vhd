library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity riconoscitore_sequenza is
    port(   i : in STD_LOGIC;
            m : in STD_LOGIC;
            a : in STD_LOGIC;
            y : out STD_LOGIC
    );
end riconoscitore_sequenza;

architecture behavioural of riconoscitore_sequenza is
    type stato is (q0, q1, q2, q3, q4);
    signal stato_corrente : stato := q0;
    signal stato_prossimo : stato;
    signal uscita_corrente : STD_LOGIC := 'U';

begin
    calcolo_transizione : process(m, i, stato_corrente)
    begin
        case m is
            when '0' =>
                case stato_corrente is
                    when q0 => 
                        if(i = '1') then
                            stato_prossimo <= q2;
                            uscita_corrente <= '0';
                        else
                            stato_prossimo <= q1;
                            uscita_corrente <= '0';
                        end if;
                    when q1 =>
                        stato_prossimo <= q3;
                        uscita_corrente <= '0';
                    when q2 =>
                        if(i = '1') then
                            stato_prossimo <= q3;
                            uscita_corrente <= '0';
                        else
                            stato_prossimo <= q4;
                            uscita_corrente <= '0';
                        end if;
                    when q3 =>
                        stato_prossimo <= q0;
                        uscita_corrente <= '0';
                    when q4 =>
                        stato_prossimo <= q0;
                        if(i = '1') then
                            uscita_corrente <= '1';
                        else
                            uscita_corrente <= '0';
                        end if;
                    when others => 
                        null;
                end case;
            when '1' =>
                case stato_corrente is
                    when q0 =>
                        if(i = '1') then
                            stato_prossimo <= q1;
                            uscita_corrente <= '0';
                        else 
                            stato_prossimo <= q0;
                            uscita_corrente <= '0';
                        end if;
                    when q1 =>
                        if(i = '1') then
                            stato_prossimo <= q1;
                            uscita_corrente <= '0';
                        else
                            stato_prossimo <= q2;
                            uscita_corrente <= '0';
                        end if;
                    when q2 =>
                        stato_prossimo <= q0;
                        if(i = '1') then
                            uscita_corrente <= '1';
                        else 
                            uscita_corrente <= '0';
                        end if;
                    when others =>  
                    null;
                end case;
            when others =>
                null;                
        end case; 
    end process;


    tempificazione : process(a)
    begin
        if rising_edge(a) then
            stato_corrente <= stato_prossimo;
            y <= uscita_corrente;
        end if;
    end process;

end behavioural;

