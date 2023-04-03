-- Arquivo adaptado baseado em demo_som.vhd, disponível
-- no site da disciplina

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity seletor_som is
	port (
        clock 		: in  std_logic;
        toca 		: in  std_logic_vector(3 downto 0);
        saida 		: out std_logic
    );
end entity;
	 
architecture estrutural of seletor_som is

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
            entrada   : in  std_logic_vector(3 downto 0);
            saida     : out std_logic_vector(9 downto 0)
        );
    end component;

signal not_s_notas, s_notas, tom : std_logic_vector(9 downto 0);

begin
	escolhe_nota : decoder_a
		port map(
        entrada   => toca,
        saida     => s_notas
	);

    not_s_notas <= not s_notas;
	
	F4 : contador_m
		generic map(
        M => 143172
		)
		port map(
        clock   => clock,
        zera_as => '0',
        zera_s  => not_s_notas(0),
        conta   => s_notas(0),
        Q       => open,
        fim     => open,
        meio    => tom(0)
		);
	
	G4 : contador_m
		generic map(
        M => 127551
		)
		port map(
        clock   => clock,
        zera_as => '0',
        zera_s  => not_s_notas(1),
        conta   => s_notas(1),
        Q       => open,
        fim     => open,
        meio    => tom(1)
		);
		
	A4 : contador_m
		generic map(
        M => 113636
		)
		port map(
        clock   => clock,
        zera_as => '0',
        zera_s  => not_s_notas(2),
        conta   => s_notas(2),
        Q       => open,
        fim     => open,
        meio    => tom(2)
		);
		
	B4 : contador_m
		generic map(
        M => 101239
		)
		port map(
        clock   => clock,
        zera_as => '0',
        zera_s  => not_s_notas(3),
        conta   => s_notas(3),
        Q       => open,
        fim     => open,
        meio    => tom(3)
		);
	
	C5 : contador_m
		generic map(
        M => 95556
		)
		port map(
        clock   => clock,
        zera_as => '0',
        zera_s  => not_s_notas(4),
        conta   => s_notas(4),
        Q       => open,
        fim     => open,
        meio    => tom(4)
		);
		
	D5 : contador_m
		generic map(
        M => 85131
		)
		port map(
        clock   => clock,
        zera_as => '0',
        zera_s  => not_s_notas(5),
        conta   => s_notas(5),
        Q       => open,
        fim     => open,
        meio    => tom(5)
		);
	
	E5 : contador_m
		generic map(
        M => 75843
		)
		port map(
        clock   => clock,
        zera_as => '0',
        zera_s  => not_s_notas(6),
        conta   => s_notas(6),
        Q       => open,
        fim     => open,
        meio    => tom(6)
		);
    F5 : contador_m
    generic map(
    M => 71586
    )
    port map(
    clock   => clock,
    zera_as => '0',
    zera_s  => not_s_notas(7),
    conta   => s_notas(7),
    Q       => open,
    fim     => open,
    meio    => tom(7)
    );
    A_sharp4 : contador_m
    generic map(
    M => 107259
    )
    port map(
    clock   => clock,
    zera_as => '0',
    zera_s  => not_s_notas(8),
    conta   => s_notas(8),
    Q       => open,
    fim     => open,
    meio    => tom(8)
    );
    D_sharp5 : contador_m
    generic map(
    M => 80353
    )
    port map(
    clock   => clock,
    zera_as => '0',
    zera_s  => not_s_notas(9),
    conta   => s_notas(9),
    Q       => open,
    fim     => open,
    meio    => tom(9)
    );


	
	saida <= tom(9) or tom(8) or tom(7) or tom(6) or tom(5) or tom(4) or tom(3) or tom(2) or tom(1) or tom(0);
	 
	end architecture;