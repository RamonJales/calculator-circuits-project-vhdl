library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- Import numeric library to treat vectors as integers for easier arithmetic logic.
use IEEE.NUMERIC_STD.ALL; 

entity bcd7seg is
    Port (
        Result_in : in  STD_LOGIC_VECTOR (5 downto 0); -- 6-bit result from the full_adder
        
        -- Outputs for the 7-segment displays (pattern: g, f, e, d, c, b, a)
        Display1  : out STD_LOGIC_VECTOR (6 downto 0); -- Tens / Sign display
        Display0  : out STD_LOGIC_VECTOR (6 downto 0)  -- Units display
    );
end bcd7seg;

architecture Behavioral of bcd7seg is

    -- Internal signals for arithmetic operations
    signal integer_val : integer := 0;
    signal abs_val     : integer := 0;
    signal is_neg      : boolean := false;
    
    signal digit_tens  : integer := 0;
    signal digit_units : integer := 0;

begin
    -- 1. PARSER: Convert logic vector to integer
    integer_val <= to_integer(signed(Result_in));
    is_neg      <= integer_val < 0;
    abs_val     <= abs(integer_val);

    -- 2. BUSINESS LOGIC: Digit separation
    -- Max sum is 9+9=18, so the tens digit can only be '1' or '0'.
    digit_tens  <= 1 when abs_val >= 10 else 0;
    digit_units <= abs_val - 10 when abs_val >= 10 else abs_val;

    -- 3. RENDER: Tens display mapping (Display1)
    process(is_neg, digit_tens)
    begin
        if is_neg then
            -- Operand A is 0 to 9. Max subtraction is 0 - 9 = -9.
            Display1 <= "1000000"; 
        elsif digit_tens = 1 then
            -- Turn on segments B and C to display '1'
            Display1 <= "0000110"; 
        else
            -- Turn off display (leading zeros are not shown)
            Display1 <= "0000000"; 
        end if;
    end process;

    -- 4. RENDER: Units display mapping (Display0)
    process(digit_units)
    begin
        -- Bit pattern: g f e d c b a (1 = LED ON, 0 = LED OFF)
        case digit_units is
            when 0 => Display0 <= "0111111"; -- Displays '0' (only 'g' is OFF)
            when 1 => Display0 <= "0000110"; -- Displays '1' (segments b, c)
            when 2 => Display0 <= "1011011"; -- Displays '2'
            when 3 => Display0 <= "1001111"; -- Displays '3'
            when 4 => Display0 <= "1100110"; -- Displays '4'
            when 5 => Display0 <= "1101101"; -- Displays '5'
            when 6 => Display0 <= "1111101"; -- Displays '6'
            when 7 => Display0 <= "0000111"; -- Displays '7'
            when 8 => Display0 <= "1111111"; -- Displays '8'
            when 9 => Display0 <= "1101111"; -- Displays '9'
            when others => Display0 <= "0000000"; -- Default case for safety
        end case;
    end process;

end Behavioral;
