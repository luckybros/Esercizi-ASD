library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity m_machine is 
    port(   a : in STD_LOGIC_VECTOR(7 downto 0);
            y0 : out STD_LOGIC_VECTOR(3 downto 0)
    );
end m_machine;

architecture structural of m_machine is

    component encoder_4_2 is 
        port(   x : in STD_LOGIC_VECTOR (3 downto 0);
                y : out STD_LOGIC_VECTOR (1 downto 0)
        );
    end component;

    begin 
        encoder_1 : encoder_4_2 
            port map(   x(0) => a(0),
                        x(1) => a(1),
                        x(2) => a(2),
                        x(3) => a(3),
                        y(0) => y0(0),
                        y(1) => y0(1),
            );
        
        encoder_2 : encoder_4_2 
            port map(   x(0) => a(4),
                        x(1) => a(5),
                        x(2) => a(6),
                        x(3) => a(7),
                        y(0) => y0(2),
                        y(1) => y0(3),
            );

end structural;