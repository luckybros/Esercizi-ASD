library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sistema is
    port(   ingresso : in std_logic_vector(7 downto 0);
            bottoni : in std_logic_vector(1 downto 0);
            sel_mux : in std_logic_vector(3 downto 0);
            sel_demux : in std_logic_vector(1 downto 0);
            uscita : out std_logic_vector(3 downto 0)
    );
end sistema;

architecture structural of sistema is 
    signal ingresso_sel : std_logic_vector(15 downto 0);

    component unita_di_controllo is 
        port(   switch_in : in std_logic_vector(7 downto 0);
                buttons : in std_logic_vector(1 downto 0);
                switch_out : out std_logic_vector(15 downto 0)
        );
    end component;

    component net16_4 is
        port(   net16_4_a : in STD_LOGIC_VECTOR(15 downto 0);
                net16_4_s_mux : in STD_LOGIC_VECTOR(3 downto 0);
                net16_4_s_demux : in STD_LOGIC_VECTOR(1 downto 0);
                net16_4_y : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

begin 
    unita_di_controllo : unita
        port map (  switch_in => ingresso, 
                    buttons => bottoni,
                    switch_out => ingresso_sel
        );
    net16_4 : rete
        port map (  net16_4_a => ingresso_sel,
                    net16_4_s_mux => sel_mux,
                    net16_4_s_demux => sel_demux,
                    net16_4_y => uscita
        );
end structural;