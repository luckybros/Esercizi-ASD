library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.numeric_std.ALL;

entity PO_PC is
    port (
        clock : in std_logic;
        reset : in std_logic;
        inizio : in std_logic;
        uscita : out std_logic_vector(3 downto 0);
        fine : out std_logic
    );
end PO_PC;

architecture structural of PO_PC is

    signal fine_conteggio : std_logic;
    signal lettura : std_logic;
    signal scrittura : std_logic;
    signal abilitazione_contatore : std_logic;
    signal reset_contatore : std_logic;
    signal indirizzo : std_logic_vector(3 downto 0);
    signal dato : std_logic_vector(3 downto 0);

    component s_system is
        port (
            in_system : in std_logic_vector(3 downto 0);
            clk_system : in std_logic;
            rd_system : in std_logic;
            out_system : out std_logic_vector(3 downto 0)
        );
    end component;

    component mem is 
        port (
            address_mem : in std_logic_vector(3 downto 0);
            data : inout std_logic_vector(3 downto 0);
            clk_mem : in std_logic;
            wrt : in std_logic
        );
    end component;

    component counter_mod_16 is 
        port (
            clk_ctr, rst_ctr, en_ctr : in std_logic;
            curr_value : out std_logic_vector(3 downto 0);
            out_ctr : out std_logic
        );
    end component;

    component control_unit is
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
    end component;

begin
    cu0: control_unit
        port map(
            start => inizio,
            clk_cu => clock,
            end_count => fine_conteggio,
            rst_cu => reset,
            rd_cu => lettura,
            wrt_cu => scrittura,
            en_cu => abilitazione_contatore,
            rst_ctr => reset_contatore,
            end_cu => fine
        );

    ctr0 : counter_mod_16
        port map(
            clk_ctr => clock, 
            rst_ctr => reset_contatore, 
            en_ctr => abilitazione_contatore,
            curr_value => indirizzo,
            out_ctr => fine_conteggio
        );

    s_system0: s_system
        port map(
            in_system => indirizzo,
            clk_system => clock,
            rd_system => lettura,
            out_system => dato
        );

    mem0 : mem
        port map(
            address_mem => indirizzo,
            data => dato,
            data => uscita,
            clk_mem => clock,
            wrt => scrittura 
        );
end structural;

