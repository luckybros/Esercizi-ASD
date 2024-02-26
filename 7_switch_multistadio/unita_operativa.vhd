library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unita_operativa is 
    port(
        ingresso: in STD_LOGIC_VECTOR(3 downto 0);
        selezione: in STD_LOGIC_VECTOR(3 downto 0);
        uscita: out STD_LOGIC_VECTOR(3 downto 0)
    );
end entity;

architecture structural of unita_operativa is
    signal temp_uscita : STD_LOGIC_VECTOR(3 downto 0);

    component switch is 
        port(
            x_switch: in STD_LOGIC_VECTOR(1 downto 0);
            sel: in STD_LOGIC_VECTOR(1 downto 0);
            y_switch: out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

begin
    switch0: switch
        port map(
            x_switch(0) => ingresso(0),
            x_switch(1) => ingresso(2),
            sel(0) => selezione(0),
            sel(1) => selezione(1),
            y_switch(0) => temp_uscita(0),
            y_switch(1) => temp_uscita(1)
        );

    switch1: switch
        port map(
            x_switch(0) => ingresso(1),
            x_switch(1) => ingresso(3),
            sel(0) => selezione(0),
            sel(1) => selezione(1),
            y_switch(0) => temp_uscita(2),
            y_switch(1) => temp_uscita(3)
        );

    switch2: switch
        port map(
            x_switch(0) => temp_uscita(0),
            x_switch(1) => temp_uscita(2),
            sel(0) => selezione(2),
            sel(1) => selezione(3),
            y_switch(0) => uscita(0),
            y_switch(1) => uscita(1)
        );

    switch3: switch
        port map(
            x_switch(0) => temp_uscita(1),
            x_switch(1) => temp_uscita(3),
            sel(0) => selezione(2),
            sel(1) => selezione(3),
            y_switch(0) => uscita(2),
            y_switch(1) => uscita(3)
        );
end architecture;
