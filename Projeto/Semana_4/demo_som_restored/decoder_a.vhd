library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity decoder_a is

	port (
        entrada   : in  std_logic_vector(2 downto 0);
        saida     : out std_logic_vector(6 downto 0)
    );
end entity;

architecture behavioral of decoder_a is

	begin
		with entrada select saida <=
			"0000001" when "110",
			"0000010" when "101",
			"0000100" when "100",
			"0001000" when "011",
			"0010000" when "010",
			"0100000" when "001",
			"1000000" when "000",
			"0000000" when others;
end architecture;