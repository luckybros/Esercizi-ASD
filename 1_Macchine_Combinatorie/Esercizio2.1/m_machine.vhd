library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity m_machine is
    port( a_m : in STD_LOGIC_VECTOR(7 downto 0);
          y_m : out STD_LOGIC_VECTOR(3 downto 0)
    );
end m_machine;

architecture structural of m_machine is
    
    component encoder42 is
        port(   a : in STD_LOGIC_VECTOR(3 downto 0);
                y : out STD_LOGIC_VECTOR(1 downto 0)
        );
    end component;

    signal a_temp1, a_temp2 : STD_LOGIC_VECTOR(3 downto 0);

    begin
        a_temp1 <= a_m(3 downto 0);
        a_temp2 <= a_m(7 downto 4);

        encoder1 : encoder42
        port map(
            a => a_temp1,
            y => y_m(1 downto 0)
        );
        
        encoder2 : encoder42
        port map(
            a => a_temp2,
            y => y_m(3 downto 2)
        );
    end structural;
