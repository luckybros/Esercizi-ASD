library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity control_unit is
    port (
        start   : in std_logic;
        clk_cu  : in std_logic;
        end_count  : in std_logic;
        rst_cu  : in std_logic;
        rd_cu   : out std_logic;
        wrt_cu  : out std_logic;
        en_cu   : out std_logic;
        rst_ctr : out std_logic;
        end_cu :  out std_logic
    );
end control_unit;

architecture behavioural of control_unit is
    type state_cu is (IDLE, OP, FINISHED);
    signal current_state : state_cu := IDLE;
    signal next_state    : state_cu := IDLE;

begin
    process(clk_cu)
    begin
        if rising_edge(clk_cu) then
            current_state <= next_state;

            case current_state is
                when IDLE =>
                    if start = '1' then
                        next_state <= OP;
                    else
                        next_state <= IDLE;
                    end if;
                when OP =>
                if rst_cu = '1' then
                    rst_ctr <= '1';
                    next_state <= FINISHED;
                else
                    en_cu  <= '1';
                    rd_cu  <= '1';
                    wrt_cu <= '1';
            
                    if end_count = '1' then
                        next_state <= FINISHED;
                    else
                        next_state <= OP;
                    end if;
                end if;
            
                when FINISHED =>
                    en_cu  <= '0';
                    rd_cu  <= '0';
                    wrt_cu <= '0';
                    end_cu <= '1';
                    next_state <= IDLE;
            end case;
        end if;
    end process;

end behavioural;

