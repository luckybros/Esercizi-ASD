library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity unita_b is
    port(
        ingresso : in std_logic;
        srt : in std_logic;
        ck, rst : in std_logic;
        invio_avvenuto : in std_logic;
        ricezione_completata : out std_logic
    );
    end unita_b;

architecture structural of unita_b is

    component mem_B is 
    port(
        address_mem_B    : in std_logic_vector(2 downto 0);
        data             : in std_logic_vector(7 downto 0);
        clk_mem_B        : in std_logic;
        wrt              : in std_logic
    );
    end component;

    component counter_mod_8 is 
    port (
        clk_ctr, rst_ctr, en_ctr : in std_logic;
        curr_value : out std_logic_vector(2 downto 0)
    );
    end component;

    component Rs232RefComp is
        Port ( 
            TXD 	: out std_logic  	:= '1';
            RXD 	: in  std_logic;
            CLK 	: in  std_logic;
            DBIN 	: in  std_logic_vector (7 downto 0);
            DBOUT : out std_logic_vector (7 downto 0);	
            RDA	: inout std_logic;						
            TBE	: inout std_logic 	:= '1';				
            RD		: in  std_logic;					
            WR		: in  std_logic;					
            PE		: out std_logic;					
            FE		: out std_logic;					
            OE		: out std_logic;					
            RST		: in  std_logic	:= '0');			
    end component;

    signal temp_address : std_logic_vector(2 downto 0);
    signal fine : std_logic := '0';
    signal temp_write : std_logic;
    signal temp_rd : std_logic;
    signal temp_rda : std_logic;
    signal temp_en_ctr : std_logic;
    signal temp_in : std_logic_vector(7 downto 0);
    signal temp_read : std_logic;
    signal temp_tbe : std_logic;
    signal temp_wr : std_logic;
    signal temp_txd : std_logic;
    signal temp_dbin : std_logic_vector(7 downto 0);
    signal temp_PE : std_logic;
    signal temp_FE : std_logic;
    signal temp_OE : std_logic;
    type state is(IDLE, RICEZIONE, SALVATAGGIO);
    signal current_state, next_state : state;


    begin
        cntr : counter_mod_8
            port map(   clk_ctr => ck,
                        rst_ctr => rst, 
                        en_ctr => temp_en_ctr,
                        curr_value => temp_address
            );

        MEM : mem_B
            port map(   address_mem_B => temp_address,
                        data => temp_in,
                        clk_mem_B => ck, 
                        wrt => temp_write
            );

        UART : Rs232RefComp
            port map(   TXD => temp_txd,
                        RXD => ingresso,
                        CLK => ck,
                        DBIN => temp_dbin,	
                        DBOUT => temp_in,  	
                        RDA	=> temp_rda, 						
                        TBE => temp_tbe,
                        RD => temp_rd,						
                        WR => temp_wr,					
                        PE => temp_PE,			
                        FE => temp_FE,					
                        OE => temp_OE,					
                        RST => rst
            );
        
        reg_stato: process(ck) 
            begin
                if(ck'event and ck='1') then
                    if(rst = '1') then 
                        current_state <=IDLE;
                    else 
                        current_state <=next_state;
                    end if;
                end if;
        end process;

        comb: process(current_state, srt, invio_avvenuto, temp_rda, fine)
        begin

            case current_state is
                when IDLE =>
                    temp_rd <= '0';
                    temp_en_ctr <= '0';
                    temp_write <= '0';
                    ricezione_completata <= '0';
                    if(srt = '1' and fine = '0') then
                        next_state <= RICEZIONE;
                    else
                        next_state <= IDLE;
                    end if;
                
                when RICEZIONE =>
                    if(invio_avvenuto = '1') then                        
                        if(temp_rda = '1') then                            
                            next_state <= SALVATAGGIO;
                        else
                            next_state <= RICEZIONE;
                        end if;
                    else
                        next_state <= RICEZIONE;
                    end if;

                when SALVATAGGIO =>
                    ricezione_completata <= '1';
                    temp_rd <= '1';
                    temp_en_ctr <= '1';
                    temp_write <= '1';

                    if(temp_address = "111") then
                        fine <= '0';
                        next_state <= IDLE;
                    else
                        next_state <= IDLE;
                    end if;           

                when others =>
                        null;

                end case;
        end process;

end structural;