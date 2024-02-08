library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity shiftregisterstructural is 
    generic (
        n : integer := 8
    );
    port (
        ei, clock, reset: in std_logic;
        selection : in std_logic_vector(1 downto 0); -- 00 sinistra 1, 01 sinistra 2, 10 destra 1, 11 destra 2
        eo : out std_logic_vector(n-1 downto 0)
    );
end shiftregisterstructural;

architecture structural of shiftregisterstructural is 
    signal temp : std_logic_vector(n-1 downto 0) := (others => '0');
    signal y_temp: std_logic_vector(n-1 downto 0) := (others => '0');
    signal s : std_logic_vector(1 downto 0);

    component mux41 is 
        port (
            b0, b1, b2, b3, s0, s1  : in std_logic;
            y0  :   out std_logic
        );
    end component;

    component flipflopd is
        port (
            ck : in std_logic;
            d : in std_logic;
            q : out std_logic
        );
    end component;

begin 
    -- Connessione del segnale di selezione ai multiplexer
    s <= selection;

    -- Logica di reset asincrono per i flip-flop
    process(clock, reset)
    begin
        if reset = '1' then
            y_temp <= (others => '0');
        elsif rising_edge(clock) then
            y_temp <= temp;
        end if;
    end process;

    mux0: mux41
        port map(
            b0 => y_temp(1),
            b1 => y_temp(2),
            b2 => ei,
            b3 => ei,
            s0 => s(0),
            s1 => s(1),
            y0 => temp(0)
        );
    
    mux1: mux41
        port map(
            b0 => y_temp(2),
            b1 => y_temp(3),
            b2 => y_temp(0),
            b3 => ei,
            s0 => s(0),
            s1 => s(1),
            y0 => temp(1)
        );
    
    mux6: mux41
        port map(
            b0 => y_temp(n-1),
            b1 => ei,
            b2 => y_temp(n-3),
            b3 => y_temp(n-4),
            s0 => s(0),
            s1 => s(1),
            y0 => temp(n-2)
        );

    mux7: mux41
        port map(
            b0 => ei,
            b1 => ei,
            b2 => y_temp(n-2),
            b3 => y_temp(n-3),
            s0 => s(0),
            s1 => s(1),
            y0 => temp(n-1)
        );

    creazione_mux: for i in 2 to (n-3) generate
        mux : mux41
            port map (
                b0 => y_temp(i+1),
                b1 => y_temp(i+2),
                b2 => y_temp(i-1),
                b3 => y_temp(i-2),
                s0 => s(0),
                s1 => s(1),
                y0 => temp(i)
            );
    end generate creazione_mux;

    creazione_flip_flop : for i in 0 to (n-1) generate
        flip_flop : flipflopd
            port map (
                ck => clock, 
                d => temp(i),
                q => y_temp(i)
            );
    end generate creazione_flip_flop;


    eo <= y_temp;

end structural;