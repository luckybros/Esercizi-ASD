library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity omega_network is
    port(
        abilitazione: in STD_LOGIC_VECTOR(3 downto 0);
        ing0: in STD_LOGIC_VECTOR(2 downto 0);
        ing1: in STD_LOGIC_VECTOR(2 downto 0);
        ing2: in STD_LOGIC_VECTOR(2 downto 0);
        ing3: in STD_LOGIC_VECTOR(2 downto 0);
        uscita_sistema: out STD_LOGIC_VECTOR(3 downto 0)
    );
end omega_network;

architecture structural of omega_network is 

signal temp_sorgente: STD_LOGIC_VECTOR(1 downto 0);
signal temp_destinazione: STD_LOGIC_VECTOR(1 downto 0);

    component gestore is
        port(
            en0, en1, en2, en3 : in STD_LOGIC;
            sel_sorgente: out STD_LOGIC_VECTOR(1 downto 0)
        );
        end component;

    component unita_operativa is
        port(
            ingresso: in STD_LOGIC_VECTOR(3 downto 0);
            selezione: in STD_LOGIC_VECTOR(3 downto 0);
            uscita: out STD_LOGIC_VECTOR(3 downto 0)
            );
        end component;

    begin
        gest: gestore
            port map(
                en0 => abilitazione(0),
                en1 => abilitazione(1), 
                en2 => abilitazione(2), 
                en3 => abilitazione(3),
                sel_sorgente => temp_sorgente
            );
        

        uo: unita_operativa
            port map(
                ingresso(0) => ing0(2), --i primi due bit sono la destinazione, l'ultimo è il payload
                ingresso(1) => ing1(2),
                ingresso(2) => ing2(2),
                ingresso(3) => ing3(2),
                selezione(0) => temp_sorgente(0),
                selezione(1) => temp_destinazione(0),
                selezione(2) => temp_sorgente(1), 
                selezione(3) => temp_destinazione(1),
                uscita => uscita_sistema
            );

        with temp_sorgente select

            temp_destinazione(0) <= ing0(0) when "00",
                                    ing1(0) when "01",
                                    ing2(0) when "10",
                                    ing3(0) when "11", 
                                    '-' when others;
                                    
        with temp_sorgente select
            temp_destinazione(1) <= ing0(1) when "00", 
                                    ing1(1) when "01",
                                    ing2(1) when "10",
                                    ing3(1) when "11", 
                                    '-' when others;

end structural;