library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity s_system is 
    port(  in_system : in STD_LOGIC_VECTOR (3 downto 0);
           out_system : out STD_LOGIC_VECTOR (3 downto 0);
    );
end s_system;

architecture structural of s_system is

    signal u : STD_LOGIC_VECTOR(7 downto 0);

    component rom is
        port(   address : in STD_LOGIC_VECTOR(3 downto 0);
                out_value : out STD_LOGIC_VECTOR(7 downto 0) 
        );
    end component;

    component m_machine is
        port(   a : in STD_LOGIC_VECTOR(7 downto 0);
                y0 : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    begin 
        ROM : rom
            port map(   address => in_system,
                        out_value => u
            );

        M_MACHINE : m_machine
            port map(   a => u,
                        y0 => out_system
            );

end structural;