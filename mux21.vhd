entity mux2_1 is 
    port (  a0: in std_logic;
            a1: in std_logic;
            s: in std_logic;
            y: out std_logic;
    );
end mux2_1;

architecture dataflow of mux2_1 is
    begin
        y <= ((a0 AND (NOT s)) OR (a1 AND s));
end dataflow;

architecture alternative of mux2_1 is
    begin
        y <= a0 when s = '0' else
             a1 when s = '1' else
             '-';
end alternative;

// unica condizione valutata è quella di 
// uguaglianza
architecture alternative2 of mux2_1 is
    begin
        with s select
            y <= a0 when '0',
                 a1 when '1',
                 '-' when others;
end alternative2;

architecture behavioral of mux2_1 is
    begin
        process(a0, a1, s)
            begin
            case s is
            when '0' => y <= a0;
            when '1' => y <= a1;
            when others => y <= '-';
            end case;
        end process;
end behavioral;

architecture behavioral1 of mux2_1 is
    begin
        process(a0, a1, s)
            begin
                if(s='0') then
                    y <= a0;
                eldif (s='1') then
                    y <= a1;
                else
                    y <= '-';
                end if;
        end process;
end behavioral;


 