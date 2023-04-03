library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity decoder_a is

	port (
        entrada   : in  std_logic_vector(3 downto 0);
        saida     : out std_logic_vector(9 downto 0)
    );
end entity;

architecture behavioral of decoder_a is

	begin
		with entrada select saida <=
			"0000000000" when "0000",
			"0000000001" when "0001",
			"0000000010" when "0010",
			"0000000100" when "0100",
			"0000001000" when "1000",
			"0000010000" when "0011",
			"0000100000" when "0101",
			"0001000000" when "1001",
			"0010000000" when "0110",
			"0100000000" when "1010",
			"1000000000" when "1100",
			"0000000000" when others;
end architecture;