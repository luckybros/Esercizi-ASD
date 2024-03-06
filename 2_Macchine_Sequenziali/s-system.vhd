library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity s_system is
    port(   in_system : in STD_LOGIC_VECTOR(3 downto 0);
            clk_system : in std_logic;
            rd_system : in std_logic;
            out_system : out STD_LOGIC_VECTOR(3 downto 0)
    );
end s_system;

architecture structural of s_system is
    signal u : STD_LOGIC_VECTOR(7 downto 0);
    
    component rom is 
        port(
            address : in std_logic_vector(3 downto 0);
            clk : in std_logic;
            rd : in std_logic;
            out_value : out std_logic_vector(7 downto 0) 
        );
    end component;

    component m_machine is
        port( a_machine : in STD_LOGIC_VECTOR(7 downto 0);
              y_machine : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;

    begin
        ROM_component : rom
            port map(   address => in_system,
                        clk => clk_system,
                        rd => rd_system,
                        out_value => u
            );

        M_MACHINE_component : m_machine 
            port map( a_machine => u,
                      y_machine => out_system
            );
end structural;

