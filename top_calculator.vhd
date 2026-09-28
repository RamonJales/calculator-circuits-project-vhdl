library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_calculator is
    Port (
        -- Pinos físicos do teclado
        A0, A1, A2, A3, A4, A5, A6, A7, A8, A9 : in STD_LOGIC;
        B0, B1, B2, B3, B4, B5, B6, B7, B8, B9 : in STD_LOGIC;
        ADD_btn, SUB_btn : in STD_LOGIC;
        
        -- Saídas para os displays
        Display1 : out STD_LOGIC_VECTOR (6 downto 0);
        Display0 : out STD_LOGIC_VECTOR (6 downto 0)
    );
end top_calculator;

architecture Structural of top_calculator is

    component kbd_encoder
        Port (
            A0, A1, A2, A3, A4, A5, A6, A7, A8, A9 : in STD_LOGIC;
            B0, B1, B2, B3, B4, B5, B6, B7, B8, B9 : in STD_LOGIC;
            ADD, SUB : in STD_LOGIC;
            A_out : out STD_LOGIC_VECTOR (3 downto 0);
            B_out : out STD_LOGIC_VECTOR (3 downto 0);
            OP_out : out STD_LOGIC
        );
    end component;

    component sum_sub
        Port (
            A_in   : in  STD_LOGIC_VECTOR (3 downto 0);
            B_in   : in  STD_LOGIC_VECTOR (3 downto 0);
            OP     : in  STD_LOGIC;
            Result : out STD_LOGIC_VECTOR (5 downto 0)
        );
    end component;

    component bcd7seg
        Port (
            Result_in : in  STD_LOGIC_VECTOR (5 downto 0);
            Display1  : out STD_LOGIC_VECTOR (6 downto 0);
            Display0  : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

    -- Fios internos
    signal sig_A_bin      : STD_LOGIC_VECTOR (3 downto 0);
    signal sig_B_bin      : STD_LOGIC_VECTOR (3 downto 0);
    signal sig_OP         : STD_LOGIC;
    signal sig_alu_result : STD_LOGIC_VECTOR (5 downto 0);

begin

    -- Instância Única do seu Codificador
    ENC: kbd_encoder port map (
        A0=>A0, A1=>A1, A2=>A2, A3=>A3, A4=>A4, A5=>A5, A6=>A6, A7=>A7, A8=>A8, A9=>A9,
        B0=>B0, B1=>B1, B2=>B2, B3=>B3, B4=>B4, B5=>B5, B6=>B6, B7=>B7, B8=>B8, B9=>B9,
        ADD=>ADD_btn, SUB=>SUB_btn,
        A_out=>sig_A_bin, B_out=>sig_B_bin, OP_out=>sig_OP
    );

    ALU: sum_sub port map (
        A_in=>sig_A_bin, B_in=>sig_B_bin, OP=>sig_OP, Result=>sig_alu_result
    );

    DEC: bcd7seg port map (
        Result_in=>sig_alu_result, Display1=>Display1, Display0=>Display0
    );

end Structural;
