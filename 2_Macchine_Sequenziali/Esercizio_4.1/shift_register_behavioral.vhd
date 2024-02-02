library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity shiftregisterbehavioural is
    generic(
        N : integer := 8
    );
    port(
        EI, ck, rst : in STD_LOGIC;
        choice : in STD_LOGIC; -- 0 shift dx, 1 shift sx
        y : in std_logic_vector(1 downto 0);
        memo : out STD_LOGIC_VECTOR(N-1 downto 0);
        EO : out STD_LOGIC
    );
end shiftregisterbehavioural;

architecture behavioural of shiftregisterbehavioural is
    --type y_enum is (ONE, TWO);
    --signal y_value : y_enum := ONE; -- Valore di default, puoi cambiare se necessario
    signal temp : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
    
begin
    process(ck)
        variable shifttemp : STD_LOGIC_VECTOR(N-1 downto 0) := (others => '0');
    begin
        if rising_edge(ck) then
            if rst = '1' then
                temp <= (others => '0');
            else
                shifttemp := (others => '0');
                case choice is
                    when '0' =>
                        if y = "01" then
                            shifttemp(0) := EI;
                            for i in 1 to (N-1) loop
                                shifttemp(i) := temp(i-1);
                            end loop;
                        elsif y = "10" then
                            shifttemp(0) := EI;
                            shifttemp(1) := EI;
                            for i in 2 to (N-1) loop
                                shifttemp(i) := temp(i-2);
                            end loop;
                        end if;
                        temp <= shifttemp;
                    when '1' =>
                        if y = "01" then
                            shifttemp(N-1) := EI;
                            for i in 0 to (N-2) loop
                               shifttemp(i) := temp(i+1);
                            end loop;
                        elsif y = "10" then
                            shifttemp(N-1) := EI;
                            shifttemp(N-2) := EI;
                            for i in 0 to (N-3) loop
                                shifttemp(i) := temp(i+2);
                            end loop;
                        end if;
                        temp <= shifttemp;
                    when others =>
                            null;
                end case;
            end if;
        end if;
    end process;

    EO <= temp(N-1);
    memo <= temp;  
end behavioural;
