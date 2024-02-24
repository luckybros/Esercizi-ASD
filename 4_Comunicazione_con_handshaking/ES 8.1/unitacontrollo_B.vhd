library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;
use work.all;

entity unitacontrollo_B is
    port(   init : in std_logic;
            clock_cu_B : in std_logic;
            rst_cu_B : in std_logic;

            -- ROM B.
            read_B : out std_logic;
            
            -- MEM B.
            write_B : out std_logic;

            -- CONTATORE.
            count : in std_logic_vector(3 downto 0);
            en_ctr : out std_logic;

            --HANDSHAKE
            accepted : out std_logic;
            data_ready : in std_logic;

            --SOMMA 
            somma : out std_logic
            --X : in std_logic_vector(7 downto 0);
            --Y : in std_logic_vector(7 downto 0);
            --Z : out std_logic_vector(7 downto 0)
    );
end unitacontrollo_B;

architecture structural of unitacontrollo_B is
    type state is(IDLE, WAIT_DATA_READY, ACK, ELAB, WAIT_FINE, INCR_COUNT);
    signal current_state, next_state : state;

    begin

        reg_stato: process(clock_cu_B) 
        begin
        if(clock_cu_B'event and clock_cu_B='1') then
        if(rst_cu_B='1') then 
            current_state <=IDLE;
        else 
            current_state <=next_state;
        end if;
        end if;
        end process;

        comb: process(current_state, init, data_ready, count)
        begin

            case current_state is
                when IDLE =>
                    read_B <= '0';
                    write_B <= '0';
                    en_ctr <= '0';
                    accepted <= '0';
                    somma <= '0';
                    if(init = '1') then
                        next_state <= WAIT_DATA_READY;
                    else
                        next_state <= IDLE;
                    end if;
                
                when WAIT_DATA_READY =>
                    en_ctr <= '0';
                    read_B <= '1';
                    if(data_ready = '1') then
                        next_state <= ACK;
                    else
                        next_state <= WAIT_DATA_READY;
                    end if;

                when ACK =>
                    accepted <= '1';
                    somma <= '1';
                    next_state <= ELAB;
    
                
                when ELAB =>
                    write_B <= '1';
                    next_state <= WAIT_FINE;

                when WAIT_FINE =>                    
                    if(data_ready = '0') then
                        somma <= '0';
                        accepted <= '0';
                        read_B <= '0';
                        next_state <= INCR_COUNT;
                    else
                        next_state <= WAIT_FINE;
                    end if;

                
                when INCR_COUNT =>
                    write_B <= '0';
                    en_ctr <= '1';
                    
                    if(count = "1111") then
                        next_state <= IDLE;
                    else
                        next_state <= WAIT_DATA_READY;
                    end if;

                when others =>
                        null;

                end case;
        end process;
end structural;

