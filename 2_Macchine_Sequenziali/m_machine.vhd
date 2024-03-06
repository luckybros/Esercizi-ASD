library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity m_machine is
    port( a_machine : in STD_LOGIC_VECTOR(7 downto 0);
          y_machine : out STD_LOGIC_VECTOR(3 downto 0)
    );
end m_machine;

architecture structural of m_machine is
    
    component encoder42 is

        port(   a : in STD_LOGIC_VECTOR (0 to 3);
                y : out STD_LOGIC_VECTOR (0 to 1)
        );
    
    end component;

    begin
        encoder0 : encoder42
        port map(
            a(0) => a_machine(0),
            a(1) => a_machine(1),
            a(2) => a_machine(2),
            a(3) => a_machine(3),
            y(0) => y_machine(0),
            y(1) => y_machine(1)
        );
        
        encoder1 : encoder42
        port map(
            a(0) => a_machine(4),
            a(1) => a_machine(5),
            a(2) => a_machine(6),
            a(3) => a_machine(7),
            y(0) => y_machine(2),
            y(1) => y_machine(3)
        );
    end structural;


