library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- 1. Aux Module: 1 bit complemente somator
entity full_adder is
    Port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Cin : in STD_LOGIC;
        S : out STD_LOGIC;
        Cout : out STD_LOGIC
    );
end full_adder;

architecture Hardware_Base of full_adder is
begin
    S <= A xor B xor Cin;
    Cout <= (A and B) or (Cin and (A xor B));  
end Hardware_Base;
