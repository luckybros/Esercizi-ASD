library IEEE;
use IEEE.std_logic_1164.ALL;
use work.all;

entity system is
    port( start : in std_logic;
          clock : in std_logic;
          reset : in std_logic
          --data_out : out std_logic_vector(7 downto 0)
    );
end system;

architecture structural of system is

    signal accepted : std_logic;
    signal data_ready : std_logic;
    signal temp_out : std_logic_vector(7 downto 0);

    component nodo_A is
        port(
            start_A : in std_logic;
            clk_A : in std_logic;
            rst_A : in std_logic;
            accepted_A : in std_logic;
            data_ready_A : out std_logic;
            X : out std_logic_vector(7 downto 0)
        );
    end component;

    component nodo_B is
        port(
            start_B : in std_logic;
            clk_B : in std_logic;
            rst_B : in std_logic;
            accepted_B : out std_logic;
            data_ready_B : in std_logic;
            X_B : in std_logic_vector(7 downto 0)
            --Z_B : out std_logic_vector(7 downto 0)
        );
    end component;

    begin
        A : nodo_A
            port map( start_A => start,
                      clk_A => clock,
                      rst_A => reset,
                      accepted_A => accepted,
                      data_ready_A => data_ready,
                      X => temp_out
            );

    B : nodo_B
        port map( start_B => start,
                  clk_B => clock,
                  rst_B => reset,
                  accepted_B => accepted,
                  data_ready_B => data_ready,
                  X_B => temp_out
                  --Z_B => data_out
        );
end structural;