library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sum_sub is
    port (
        A_in   : in STD_LOGIC_VECTOR (3 downto 0);  -- 4-bit input operand A
        B_in   : in STD_LOGIC_VECTOR (3 downto 0);  -- 4-bit input operand B
        OP     : in STD_LOGIC;                      -- Operation selector (1 = Add, 0 = Sub)
        Result : out STD_LOGIC_VECTOR (5 downto 0)  -- 6-bit output result (Supports -9 to +18)
    );
end entity sum_sub;

architecture Estrutural of sum_sub is
    
    -- component declaration for the 1-it full adder module
    component full_adder
        Port (
                A : in STD_LOGIC;
                B : in STD_LOGIC;
                Cin : in STD_LOGIC;
                S : out STD_LOGIC;
                Cout : out STD_LOGIC
        );
    end component;

    -- Internal signals: basically we need to transform the 4-bits numbers
    -- in 6-bits output numbers
    signal A_ext : STD_LOGIC_VECTOR(5 downto 0);
    signal B_ext : STD_LOGIC_VECTOR(5 downto 0);
    signal B_xor : STD_LOGIC_VECTOR(5 downto 0); -- operand b after conditional inversion. Subtractions is better: (A + (-B))
    signal C : STD_LOGIC_VECTOR(6 downto 0); -- use to conect the chain of numbers the carry bit(vai um) for the next bit
    signal sub_flag : STD_LOGIC; -- internal subtracition flag to facilitate

begin
    
    -- invert OP singnal to activate subtraction with 1 signal(to avoid 0 signal in operations)
    sub_flag <= not OP;

    -- just put 00 in number begining
    A_ext <= "00" & A_in;
    B_ext <= "00" & B_in;

    -- If sub_flag = '1', XOR inverts the bit. If '0', it passes unchanged
    B_xor(0) <= B_ext(0) xor sub_flag;
    B_xor(1) <= B_ext(1) xor sub_flag;
    B_xor(2) <= B_ext(2) xor sub_flag;
    B_xor(3) <= B_ext(3) xor sub_flag;
    B_xor(4) <= B_ext(4) xor sub_flag;
    B_xor(5) <= B_ext(5) xor sub_flag;
    
    -- ibject +1 for 2 complement subtraction
    c(0) <= sub_flag;

    -- run full added in each beat
    FA0: full_adder port map (A => A_ext(0), B => B_xor(0), Cin => C(0), S => Result(0), Cout => C(1));
    FA1: full_adder port map (A => A_ext(1), B => B_xor(1), Cin => C(1), S => Result(1), Cout => C(2));
    FA2: full_adder port map (A => A_ext(2), B => B_xor(2), Cin => C(2), S => Result(2), Cout => C(3));
    FA3: full_adder port map (A => A_ext(3), B => B_xor(3), Cin => C(3), S => Result(3), Cout => C(4));
    FA4: full_adder port map (A => A_ext(4), B => B_xor(4), Cin => C(4), S => Result(4), Cout => C(5));
    FA5: full_adder port map (A => A_ext(5), B => B_xor(5), Cin => C(5), S => Result(5), Cout => C(6));
end Estrutural;
