library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mod_operator is
	port( X_mod, Y_mod: in std_logic_vector(7 downto 0);
          clock_mod, reset_mod, start_mod : in std_logic;
		  Z_mod: out std_logic_vector(3 downto 0)
		  );		  
end mod_operator;

architecture structural of mod_operator is 

    signal temp_x : std_logic_vector(7 downto 0);
    signal temp_ris : std_logic_vector(7 downto 0);
    signal temp_cout : std_logic;

    component adder_sub is 
        port( X, Y: in std_logic_vector(7 downto 0);
              cin: in std_logic;
              Z: out std_logic_vector(7 downto 0);
              cout: out std_logic
            );	

    begin 
        sottrattore : adder_sub
            port map (  X => temp_x,
                        Y => Y_mod,
                        cin => 1,
                        Z => temp_ris,
                        cout => temp_cout
            )

end structural;