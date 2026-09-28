library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_calculator is
end tb_calculator;

architecture Simulation of tb_calculator is

    component top_calculator
        Port (
            A0, A1, A2, A3, A4, A5, A6, A7, A8, A9 : in STD_LOGIC;
            B0, B1, B2, B3, B4, B5, B6, B7, B8, B9 : in STD_LOGIC;
            ADD_btn, SUB_btn : in STD_LOGIC;
            Display1 : out STD_LOGIC_VECTOR (6 downto 0);
            Display0 : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    -- Sinais virtuais simulando o teclado
    signal tb_A : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal tb_B : STD_LOGIC_VECTOR(9 downto 0) := (others => '0');
    signal tb_ADD : STD_LOGIC := '0';
    signal tb_SUB : STD_LOGIC := '0';
    
    signal tb_D1 : STD_LOGIC_VECTOR(6 downto 0);
    signal tb_D0 : STD_LOGIC_VECTOR(6 downto 0);

begin

    UUT: top_calculator port map (
        A0=>tb_A(0), A1=>tb_A(1), A2=>tb_A(2), A3=>tb_A(3), A4=>tb_A(4),
        A5=>tb_A(5), A6=>tb_A(6), A7=>tb_A(7), A8=>tb_A(8), A9=>tb_A(9),
        B0=>tb_B(0), B1=>tb_B(1), B2=>tb_B(2), B3=>tb_B(3), B4=>tb_B(4),
        B5=>tb_B(5), B6=>tb_B(6), B7=>tb_B(7), B8=>tb_B(8), B9=>tb_B(9),
        ADD_btn=>tb_ADD, SUB_btn=>tb_SUB,
        Display1=>tb_D1, Display0=>tb_D0
    );

    stim_proc: process
    begin
        wait for 20 ns;
        
        -- TESTE 1: 7 + 3
        tb_A(7) <= '1';
        tb_B(3) <= '1';
        tb_ADD <= '1';
        wait for 20 ns;
        tb_A <= (others=>'0'); tb_B <= (others=>'0'); tb_ADD <= '0';
        wait for 10 ns;

        -- TESTE 2: 9 - 2
        tb_A(9) <= '1';
        tb_B(2) <= '1';
        tb_SUB <= '1';
        wait for 20 ns;
        tb_A <= (others=>'0'); tb_B <= (others=>'0'); tb_SUB <= '0';
        wait for 10 ns;

        -- TESTE 3: 5 + 5
        tb_A(5) <= '1';
        tb_B(5) <= '1';
        tb_ADD <= '1';
        wait for 20 ns;
        tb_A <= (others=>'0'); tb_B <= (others=>'0'); tb_ADD <= '0';
        wait for 10 ns;

        -- TESTE 4: 8 - 8
        tb_A(8) <= '1';
        tb_B(8) <= '1';
        tb_SUB <= '1';
        wait for 20 ns;
        tb_A <= (others=>'0'); tb_B <= (others=>'0'); tb_SUB <= '0';
        wait for 10 ns;

        wait;
    end process;

end Simulation;
