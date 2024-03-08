library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity unita_a is
    port(
        start : in std_logic;
        clock, reset : in std_logic;
        uscita : out std_logic;
        invio_richiesta : out std_logic;
        ricezione_avvenuta : in std_logic
    );
    end unita_a;

architecture structural of unita_a is

    component memoria_A is 
    port(
        address : in std_logic_vector(2 downto 0);
        clk : in std_logic;
        rd : in std_logic;
        out_value : out std_logic_vector(7 downto 0) 
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
    signal temp_invio : std_logic := '0';
    signal temp_en_ctr : std_logic;
    signal temp_out : std_logic_vector(7 downto 0);
    signal temp_read : std_logic;
    signal temp_tbe : std_logic;
    signal temp_write : std_logic;
    signal temp_rxd : std_logic;
    signal temp_DBOUT : std_logic_vector(7 downto 0);
    signal temp_RDA : std_logic;
    signal temp_RD : std_logic;
    signal temp_PE : std_logic;
    signal temp_FE : std_logic;
    signal temp_OE : std_logic;
    type state is(IDLE, PREPARAZIONE, INVIO);
    signal current_state, next_state : state;


    begin
        cntr : counter_mod_8
            port map(   clk_ctr => clock,
                        rst_ctr => reset, 
                        en_ctr => temp_en_ctr,
                        curr_value => temp_address
            );

        ROM : memoria_A
            port map(   address => temp_address,
                        clk => clock,
                        rd => temp_read,
                        out_value => temp_out
            );

        UART : Rs232RefComp
            port map(   TXD => uscita,
                        RXD => temp_rxd,	
                        CLK => clock,
                        DBIN => temp_out,	
                        DBOUT => temp_DBOUT,  	
                        RDA	=> temp_RDA, 						
                        TBE => temp_tbe,
                        RD => temp_RD,						
                        WR => temp_write,					
                        PE => temp_PE,			
                        FE => temp_FE,					
                        OE => temp_OE,					
                        RST => reset
            );

        invio_richiesta <= temp_invio;
        
        reg_stato: process(clock) 
            begin
                if(clock'event and clock='1') then
                    if(reset = '1') then 
                        current_state <=IDLE;
                    else 
                        current_state <=next_state;
                    end if;
                end if;
        end process;

        comb: process(current_state, start, ricezione_avvenuta, temp_tbe, fine)
        begin

            case current_state is
                when IDLE =>
                    temp_read <= '0';
                    temp_en_ctr <= '0';
                    temp_invio <= '0';
                    if(start = '1' and fine = '0') then
                        temp_write <= '1';
                        next_state <= PREPARAZIONE;
                    else
                        temp_write <= '0';
                        next_state <= IDLE;
                    end if;
                
                when PREPARAZIONE =>
                    temp_read <= '1';
                    if(temp_tbe = '1') then
                        temp_write <= '0';
                        temp_invio <= '1';
                        next_state <= INVIO;
                    else
                        next_state <= PREPARAZIONE;
                    end if;

                when INVIO =>                    
                    temp_read <= '0';
                      
                    if(ricezione_avvenuta = '1') then
                        temp_en_ctr <= '1';
                        if(temp_address = "111") then
                            fine <= '1';
                            next_state <= IDLE;
                        else
                            next_state <= IDLE;
                        end if; 
                    else
                        next_state <= INVIO;
                    end if;        

                when others =>
                        null;

                end case;
        end process;

end structural;