--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity demo_som is

	port (
        clock 		: in  std_logic;
        toca 		: in  std_logic_vector(2 downto 0);
        saida 		: out std_logic
    );
	 end entity;
	 
architecture seila of demo_som is

component contador_m is
    generic (
        constant M: integer := 100 -- modulo do contador
    );
    port (
        clock   : in  std_logic;
        zera_as : in  std_logic;
        zera_s  : in  std_logic;
        conta   : in  std_logic;
        Q       : out std_logic_vector(natural(ceil(log2(real(M))))-1 downto 0);
        fim     : out std_logic;
        meio    : out std_logic
    );
end component;

component decoder_a is

	port (
        entrada   : in  std_logic_vector(2 downto 0);
        saida     : out std_logic_vector(6 downto 0)
    );
end component;

signal s_notas, tom : std_logic_vector(6 downto 0);

begin

	flauta : decoder_a
		port map(
        entrada   => toca,
        saida     => s_notas
		);
	
	do4 : contador_m
		generic map(
        M => 189394 -- do da quarta oitava
		)
		port map(
        clock   => clock,
        zera_as => '0',
        zera_s  => not s_notas(0),
        conta   => s_notas(0),
        Q       => open,
        fim     => open,
        meio    => tom(0)
		);
	
	re4 : contador_m
		generic map(
        M => 168805 -- re da quarta oitava
		)
		port map(
        clock   => clock,
        zera_as => '0',
        zera_s  => not s_notas(1),
        conta   => s_notas(1),
        Q       => open,
        fim     => open,
        meio    => tom(1)
		);
		
	mi4 : contador_m
		generic map(
        M => 150331 -- mi da quarta oitava
		)
		port map(
        clock   => clock,
        zera_as => '0',
        zera_s  => not s_notas(2),
        conta   => s_notas(2),
        Q       => open,
        fim     => open,
        meio    => tom(2)
		);
		
	fa4 : contador_m
		generic map(
        M => 141884 -- fa da quarta oitava
		)
		port map(
        clock   => clock,
        zera_as => '0',
        zera_s  => not s_notas(3),
        conta   => s_notas(3),
        Q       => open,
        fim     => open,
        meio    => tom(3)
		);
	
	sol4 : contador_m
		generic map(
        M => 126422 -- sol da quarta oitava
		)
		port map(
        clock   => clock,
        zera_as => '0',
        zera_s  => not s_notas(4),
        conta   => s_notas(4),
        Q       => open,
        fim     => open,
        meio    => tom(4)
		);
		
	la4 : contador_m
		generic map(
        M => 112612 -- 50 Mhz / 440 Hz la da quarta oitava
		)
		port map(
        clock   => clock,
        zera_as => '0',
        zera_s  => not s_notas(5),
        conta   => s_notas(5),
        Q       => open,
        fim     => open,
        meio    => tom(5)
		);
	
	si4 : contador_m
		generic map(
        M => 100321 -- si da quarta oitava
		)
		port map(
        clock   => clock,
        zera_as => '0',
        zera_s  => not s_notas(6),
        conta   => s_notas(6),
        Q       => open,
        fim     => open,
        meio    => tom(6)
		);
	
	saida <= tom(6) or tom(5) or tom(4) or tom(3) or tom(2) or tom(1) or tom(0);
	 
	end architecture;