library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.all;

entity system is
    port(
        sys_start, sys_clock, sys_reset : in std_logic
    );
end system;

architecture structural of system is 

    component nodo_inviante is
        port(
            start_inviante : in std_logic;
            clk_inviante : in std_logic;
            rst_inviante : in std_logic;
            accepted_inviante : in std_logic;
            data_ready_inviante : out std_logic;
            out_value_inviante : out std_logic_vector(3 downto 0)
        );
    end component;

    component nodo_c is
        port(
            start_c : in std_logic;
            clk_c : in std_logic;
            rst_c : in std_logic;
            accepted_a_c : out std_logic;
            accepted_b_c : out std_logic;
            data_ready_a_c : in std_logic;
            data_ready_b_c : in std_logic;
            X_C : in std_logic_vector(3 downto 0);
            Y_C : in std_logic_vector(3 downto 0)
        );
    end component;

    signal temp_accepted_a : std_logic;
    signal temp_accepted_b : std_logic;
    signal temp_data_ready_a : std_logic;
    signal temp_data_ready_b : std_logic;
    signal temp_out_value_a : std_logic_vector(3 downto 0);
    signal temp_out_value_b : std_logic_vector(3 downto 0);

    begin
        A : nodo_inviante
            port map(
                start_inviante => sys_start,
                clk_inviante => sys_clock,
                rst_inviante => sys_reset,
                accepted_inviante => temp_accepted_a,
                data_ready_inviante => temp_data_ready_a,
                out_value_inviante => temp_out_value_a
            );

        B : nodo_inviante
            port map(
                start_inviante => sys_start,
                clk_inviante => sys_clock,
                rst_inviante => sys_reset,
                accepted_inviante => temp_accepted_b,
                data_ready_inviante => temp_data_ready_b,
                out_value_inviante => temp_out_value_b
            );

        C : nodo_c
            port map(
                start_c => sys_start,
                clk_c => sys_clock,
                rst_c => sys_reset,
                accepted_a_c => temp_accepted_a,
                accepted_b_c => temp_accepted_b,
                data_ready_a_c => temp_data_ready_a,
                data_ready_b_c temp_data_ready_b,
                X_C => temp_out_value_a,
                Y_C => temp_out_value_b
            );

end structural;