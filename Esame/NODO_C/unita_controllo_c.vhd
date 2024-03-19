library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
use work.all;

entity unita_controllo_c is
    port(   init : in std_logic;
            clock_cu_c : in std_logic;
            rst_cu_c : in std_logic;
            
            -- MEM C.
            write_c : out std_logic;

            -- CONTATORE.
            count : in std_logic_vector(2 downto 0);
            en_ctr : out std_logic;

            --HANDSHAKE
            accepted_a : out std_logic;
            accepted_b : out std_logic;
            data_ready_a : in std_logic;
            data_ready_b : in std_logic;

            --MACCHINA ARITMETICA 
            start_m : out std_logic;
            end_m : in std_logic;
    );
end unita_controllo_c;

architecture structural of unita_controllo_c is
    type state is(IDLE, WAIT_DATA_READY, ACK, ELAB, WRITING, WAIT_FINE, INCR_COUNT);
    signal current_state, next_state : state;

    begin

        reg_stato: process(clock_cu_c) 
        begin
            if(clock_cu_c'event and clock_cu_c='1') then
                if(rst_cu_c='1') then 
                    current_state <= IDLE;
                else 
                    current_state <= next_state;
                end if;
            end if;
        end process;

        comb: process(current_state, init, data_ready_a, data_ready_b, count)
        begin

            case current_state is
                when IDLE =>
                    write_c <= '0';
                    en_ctr <= '0';
                    accepted_a <= '0';
                    accepted_b <= '0';
                    start_m <= '0';
                    if(init = '1') then
                        next_state <= WAIT_DATA_READY;
                    else
                        next_state <= IDLE;
                    end if;
                
                when WAIT_DATA_READY =>
                    en_ctr <= '0';
                    if(data_ready_a = '1' and data_ready_b = '1') then
                        next_state <= ACK;
                    else
                        next_state <= WAIT_DATA_READY;
                    end if;

                when ACK =>
                    accepted_a <= '1';
                    accepted_b <= '1';
                    start_m <= '1';
                    next_state <= ELAB;
    
                
                when ELAB =>
                    if(end_m = '1')
                        next_state <= WRITING;
                    else
                        next_state <= ELAB;
        

                when WRITING =>
                    write_c = '1';
                    next_state <= WAIT_FINE;
                

                when WAIT_FINE =>                    
                    if(data_ready_a = '0' and data_ready_b = '0') then
                        start_m <= '0';
                        accepted_a <= '0';
                        accepted_b <= '0';
                        next_state <= INCR_COUNT;
                    else
                        next_state <= WAIT_FINE;
                    end if;

                
                when INCR_COUNT =>
                    write_c <= '0';
                    en_ctr <= '1';
                    
                    if(count = "111") then
                        next_state <= IDLE;
                    else
                        next_state <= WAIT_DATA_READY;
                    end if;

                when others =>
                        null;

                end case;
        end process;
end structural;

