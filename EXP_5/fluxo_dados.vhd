--------------------------------------------------------------------
-- Arquivo   : circuito_exp2_ativ2.vhd.parcial.txt
-- Projeto   : Experiencia 2 - Um Fluxo de Dados Simples
--------------------------------------------------------------------
-- Descricao : ARQUIVO PARCIAL DO
--    Circuito do fluxo de dados da Atividade 2
--
-- COMPLETAR TRECHOS DE CODIGO ABAIXO
--
--    1) contem saidas de depuracao db_contagem e db_memoria
--    2) escolha da arquitetura do componente ram_16x4
--       para simulacao com ModelSim => ram_modelsim
--    3) escolha da arquitetura do componente ram_16x4
--       para sintese com Intel Quartus => ram_mif
--
--------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     11/01/2022  1.0     Edson Midorikawa  versao inicial
--     07/01/2023  1.1     Edson Midorikawa  revisao
--     10/02/2023  1.1.1   Edson Midorikawa  arquivo parcial
--------------------------------------------------------------------
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity fluxo_dados is
    port (
      clock         : in  std_logic;
      zeraC         : in  std_logic;
      contaC        : in  std_logic;
      escreveM      : in  std_logic;
      zeraR         : in  std_logic;
	   registraR     : in std_logic;
		chaves        : in  std_logic_vector (3 downto 0);
		contaTempo	  : in std_logic; -- desafio
      igual         : out std_logic;
      fimC          : out std_logic;
      jogada_feita  : out std_logic;
      db_tem_jogada : out std_logic; 
      db_contagem   : out std_logic_vector (3 downto 0);
      db_memoria    : out std_logic_vector (3 downto 0);
		db_chaves     : out std_logic_vector(3 downto 0);
		fimTempo		  : out std_logic -- desafio
	);
end entity;

architecture estrutural of fluxo_dados is

  signal s_endereco    : std_logic_vector (3 downto 0);
  signal s_dado        : std_logic_vector (3 downto 0);
  signal s_not_zera    : std_logic;
  signal s_not_escreve : std_logic;
  signal s_chaves      : std_logic_vector(3 downto 0);
  signal zeraT         : std_logic;
  -- Adicionado para exp 4 --
  signal s_chaveacionada  : std_logic := '0';

  component contador_163
    port (
        clock : in  std_logic;
        clr   : in  std_logic;
        ld    : in  std_logic;
        ent   : in  std_logic;
        enp   : in  std_logic;
        D     : in  std_logic_vector (3 downto 0);
        Q     : out std_logic_vector (3 downto 0);
        rco   : out std_logic 
    );
  end component;

  component comparador_85
    port (
        i_A3   : in  std_logic;
        i_B3   : in  std_logic;
        i_A2   : in  std_logic;
        i_B2   : in  std_logic;
        i_A1   : in  std_logic;
        i_B1   : in  std_logic;
        i_A0   : in  std_logic;
        i_B0   : in  std_logic;
        i_AGTB : in  std_logic;
        i_ALTB : in  std_logic;
        i_AEQB : in  std_logic;
        o_AGTB : out std_logic;
        o_ALTB : out std_logic;
        o_AEQB : out std_logic
    );
  end component;

  component ram_16x4 is
    port (
       clk          : in  std_logic;
       endereco     : in  std_logic_vector(3 downto 0);
       dado_entrada : in  std_logic_vector(3 downto 0);
       we           : in  std_logic;
       ce           : in  std_logic;
       dado_saida   : out std_logic_vector(3 downto 0)
    );
  end component;
  
  -- Adicionado --
  component registrador_n is
    generic (
        constant N: integer := 8 
    );
    port (
        clock  : in  std_logic;
        clear  : in  std_logic;
        enable : in  std_logic;
        D      : in  std_logic_vector (N-1 downto 0);
        Q      : out std_logic_vector (N-1 downto 0) 
    );
  end component;
  
  -- Adicionado exp_4 --
  component edge_detector is
    port (
      clock : in std_logic;
      reset : in std_logic;
      sinal : in std_logic;
      pulso : out std_logic
    );
  end component;
  
  component contador_m is
	generic (
		constant M : integer := 100
	);
	port (
		clock	: in std_logic;
		zera_as	: in std_logic;
		zera_s	: in std_logic;
		conta		: in std_logic;
		Q			: out std_logic_vector(natural(ceil(log2(real(M)))) - 1 downto 0);
		fim		: out std_logic;
		meio		: out std_logic
	);
  end component;
  
begin

  -- sinais de controle ativos em alto
  -- sinais dos componentes ativos em baixo
  s_not_zera    <= not zeraC;
  s_not_escreve <= not escreveM;

  s_chaveacionada <= chaves(3) or chaves(2) or chaves(1) or chaves(0);
  
  contador: contador_163
    port map (
        clock => clock,
        clr   => s_not_zera,  -- clr ativo em baixo
        ld    => '1',
        ent   => '1',
        enp   => contaC,
        D     => "0000",
        Q     => s_endereco,
        rco   => fimC
    );

  comparador: comparador_85
    port map (
		i_A3   => s_dado(3),
        i_B3   => s_chaves(3),
        i_A2   => s_dado(2),
        i_B2   => s_chaves(2),
        i_A1   => s_dado(1),
        i_B1   => s_chaves(1),
        i_A0   => s_dado(0),
        i_B0   => s_chaves(0),
        i_AGTB => '0',
        i_ALTB => '0',
        i_AEQB => '1',
        o_AGTB => open, -- saidas nao usadas
        o_ALTB => open,
        o_AEQB => igual
    );

  memoria: entity work.ram_16x4 (ram_mif)  -- usar esta linha para Intel Quartus
  --memoria: entity work.ram_16x4 (ram_modelsim) -- usar arquitetura para ModelSim
    port map (
       clk          => clock,
       endereco     => s_endereco,
       dado_entrada => s_chaves,
       we           => s_not_escreve, -- we ativo em baixo
       ce           => '0',
       dado_saida   => s_dado
    );
	
	registrador: registrador_n
		generic map( N => 4)
		port map (
			clock  => clock,
			clear  => zeraR,
			enable => registraR,
			D      => chaves,
			Q      => s_chaves
		);
	
  -- Adicionado para a exp4 --
  detector_jogada: edge_detector
    port map (
      clock => clock,
      reset => zeraR,
      sinal => s_chaveacionada,
      pulso => jogada_feita
    );
	 
	 zeraT <= contaC or zeraC;
	 
  contador_timeout: contador_m
	 generic map (
		M => 3000
	 )
	 port map (
		clock => clock,
		zera_as => zeraT,
		zera_s => '0',
		conta => contaTempo,
		Q => open,
		fim => fimTempo,
		meio => open
	 );
		
  db_contagem <= s_endereco;
  db_memoria  <= s_dado;
  
  db_chaves   <= s_chaves;
  
  -- Adicionado para a exp4 --
  db_tem_jogada <= s_chaveacionada;
end architecture estrutural;