library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity unita_controllo_inviante is
    port(   init_inviante : in std_logic;
            clk_cu_inviante : in std_logic;
            rst_cu_inviante : in std_logic;

            -- ROM A
            read_inviante : out std_logic;

            -- CONTATORE.
            count : in std_logic_vector(2 downto 0);
            en_ctr : out std_logic;

            --HANDSHAKE
            accepted : in std_logic;
            data_ready : out std_logic
    );
end unitacontrollo_inviante;

architecture structural of unitacontrollo_inviante is
    type state is(IDLE, READ_DATA, WAIT_ACK, WAIT_ELAB, INCR_COUNT);
    signal current_state, next_state : state;

    begin 

        reg_stato: process(clk_cu_inviante) 
        begin
            if(clk_cu_inviante'event and clk_cu_inviante='1') then
                if(rst_cu_inviante='1') then 
                    current_state <= IDLE;
                else 
                    current_state <= next_state;
                end if;
            end if;
        end process;

        comb: process(current_state, init, accepted, count)
        begin

            case current_state is
                when IDLE =>
                    read_inviante <= '0';
                    en_ctr <= '0';
                    data_ready <= '0';
                    if(init = '1') then
                        next_state <= READ_DATA;
                    else
                        next_state <= IDLE;
                    end if;
                
                when READ_DATA =>
                    en_ctr <= '0';
                    read_inviante <= '1';
                    data_ready <= '1';
                    next_state <= WAIT_ACK;

                when WAIT_ACK =>
                    read_inviante <= '0';
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
                    
                    if(count = "111") then
                        next_state <= IDLE;
                    else
                        next_state <= READ_DATA;
                    end if;

                when others =>
                        null;

                end case;
        end process;
end structural;

