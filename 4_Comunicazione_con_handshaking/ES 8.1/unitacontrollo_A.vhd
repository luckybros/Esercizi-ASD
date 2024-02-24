library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity unitacontrollo_A is
    port(   init : in std_logic;
            clk_cu_A : in std_logic;
            rst_cu_A : in std_logic;

            -- ROM A
            read_A : out std_logic;

            -- CONTATORE.
            count : in std_logic_vector(3 downto 0);
            en_ctr : out std_logic;

            --HANDSHAKE
            accepted : in std_logic;
            data_ready : out std_logic
    );
end unitacontrollo_A;

architecture structural of unitacontrollo_A is
    type state is(IDLE, READ_DATA, WAIT_ACK, WAIT_ELAB, INCR_COUNT);
    signal current_state, next_state : state;

    begin 

        reg_stato: process(clk_cu_A) 
        begin
        if(clk_cu_A'event and clk_cu_A='1') then
        if(rst_cu_A='1') then 
            current_state <=IDLE;
        else 
            current_state <=next_state;
        end if;
        end if;
        end process;

        comb: process(current_state, init, accepted, count)
        begin

            case current_state is
                when IDLE =>
                    read_A <= '0';
                    en_ctr <= '0';
                    data_ready <= '0';
                    if(init = '1') then
                        next_state <= READ_DATA;
                    else
                        next_state <= IDLE;
                    end if;
                
                when READ_DATA =>
                    en_ctr <= '0';
                    read_A <= '1';
                    data_ready <= '1';
                    next_state <= WAIT_ACK;

                when WAIT_ACK =>
                    read_A <= '0';
                    if(accepted = '1') then
                        data_ready <= '0';
                        next_state <= WAIT_ELAB;
                    else
                        next_state <= WAIT_ACK;
                    end if;
                
                when WAIT_ELAB =>
                    if(accepted = '0') then
                        next_state <= INCR_COUNT;
                    else
                        next_state <= WAIT_ELAB;
                    end if;
                
                when INCR_COUNT =>
                    en_ctr <= '1';
                    
                    if(count = "1111") then
                        next_state <= IDLE;
                    else
                        next_state <= READ_DATA;
                    end if;

                when others =>
                        null;

                end case;
        end process;
end structural;

