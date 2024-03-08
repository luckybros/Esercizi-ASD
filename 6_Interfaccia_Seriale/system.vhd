library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity system is
    port(
        sys_start, sys_clock, sys_reset : in std_logic
    );
end system;

architecture structural of system is 

    component unita_a is
        port(
            start : in std_logic;
            clock, reset : in std_logic;
            uscita : out std_logic;
            invio_richiesta : out std_logic;
            ricezione_avvenuta : in std_logic
        );
    end component;

    component unita_b is
        port(
            ingresso : in std_logic;
            srt : in std_logic;
            ck, rst : in std_logic;
            invio_avvenuto : in std_logic;
            ricezione_completata : out std_logic
        );
    end component;

    signal temp : std_logic;
    signal temp_invio : std_logic;
    signal temp_ricezione : std_logic;

    begin
        UA : unita_a
            port map(
                start => sys_start,
                clock => sys_clock,
                reset => sys_reset,
                uscita => temp,
                invio_richiesta => temp_invio,
                ricezione_avvenuta => temp_ricezione
            );

        UB : unita_b
            port map(
                ingresso => temp,
                srt => sys_start,
                ck => sys_clock,
                rst => sys_reset,
                invio_avvenuto => temp_invio,
                ricezione_completata => temp_ricezione
            );

end structural;