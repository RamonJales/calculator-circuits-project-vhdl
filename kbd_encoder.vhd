library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity kbd_encoder is
    Port (
        A0, A1, A2, A3, A4, A5, A6, A7, A8, A9 : in STD_LOGIC;
        
        B0, B1, B2, B3, B4, B5, B6, B7, B8, B9 : in STD_LOGIC;

        ADD, SUB : in STD_LOGIC;

        A_out : out STD_LOGIC_VECTOR (3 downto 0);
        B_out : out STD_LOGIC_VECTOR (3 downto 0);

        OP_out : out STD_LOGIC
    );
end kbd_encoder;

architecture Combinational of kbd_encoder is
begin
    A_out <= "1001" when A9 = '1' else
             "1000" when A8 = '1' else
             "0111" when A7 = '1' else
             "0110" when A6 = '1' else
             "0101" when A5 = '1' else
             "0100" when A4 = '1' else
             "0011" when A3 = '1' else
             "0010" when A2 = '1' else
             "0001" when A1 = '1' else
             "0000";

    B_out <= "1001" when B9 = '1' else
             "1000" when B8 = '1' else
             "0111" when B7 = '1' else
             "0110" when B6 = '1' else
             "0101" when B5 = '1' else
             "0100" when B4 = '1' else
             "0011" when B3 = '1' else
             "0010" when B2 = '1' else
             "0001" when B1 = '1' else
             "0000";

    OP_out <= '1' when ADD = '1' else '0';

end Combinational;
