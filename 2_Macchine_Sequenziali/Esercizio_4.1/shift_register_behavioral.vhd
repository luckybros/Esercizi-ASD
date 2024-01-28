library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.all;

entity shift_register is 
    generic( n := integer 8 );
    port(   ei, clock, reset: in std_logic;
            choice_direction : in integer range 0 to 1; -- 0 shift dx, 1 shift sx
            choice_num_shifts : in integer range 1 to 2;
            eo : out std_logic;
    );
end shift_register;

architecture behavioral of shift_register is

    signal temp : std_logic_vector(n-1 downto 0);

    process(clock)
    variable shift_temp : std_logic_vector(n-1 downto 0);
        if(rising_edge(clock)) then 
            if(reset = '1') then
                temp <= (others => '0');
            else 
                case choice_direction is 
                    when '0' =>
                        if(choice_num_shifts = '1')
                            shift_temp(0) := ei;
                            for i in 1 to n-1 loop
                                shift_temp(i) := temp(i-1);
                            end loop;
                        elsif(choice_num_shifts = '2')
                            shift_temp(0) := ei;
                            shift_temp(1) := ei;
                            for i in 2 to n-1 loop
                                shift_temp(i) := temp(i-2);
                            end loop;
                        end if;
                        temp <= shift_temp;
                    when '1' =>
                        if(choice_num_shifts = '1')
                            shift_temp(n-1) := eo;
                            for i in 0 to n-2 loop
                                shift_temp(i) := temp(i+1);
                            end loop;
                        elsif(choice_num_shifts = '2')
                            shift_temp(n-1) := ei;
                            shift_temp(n-2) := ei;
                            for i in 0 to n-3 loop
                                shift_temp(i) := temp(i+2);
                            end loop;
                        end if;
                        temp <= shift_temp;
                end case;
            end if;
        end if;         
    end process;         

end behavioral;