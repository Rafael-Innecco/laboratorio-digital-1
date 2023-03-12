--------------------------------------------------------------------
-- Arquivo   : fluxo_dados.txt
-- Projeto   : Experiencia 2 - Um Fluxo de Dados Simples
--------------------------------------------------------------------
-- Descricao :
--    Circuito do fluxo de dados do projeto da disciplina
--
--------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     11/01/2022  1.0     Edson Midorikawa  versao inicial
--     07/01/2023  1.1     Edson Midorikawa  revisao
--     10/02/2023  1.1.1   Edson Midorikawa  arquivo parcial
--     11/03/2023  2.0     Rafael Innecco    Modificacao inicial para projeto
--------------------------------------------------------------------
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity fluxo_dados is
    port (
		clock        	      : in  std_logic;
    chaves              : in  std_logic_vector (3 downto 0);
    seletor_modo        : in std_logic_vector (1 downto 0);
    -------------------------------------
		zeraC           : in  std_logic; -- novo nome: zeraC -> zeraC
		contaC   	      : in  std_logic; -- novo nome: contaC -> contaC
		escreveM     		    : in  std_logic;
		zeraR         		  : in  std_logic;
		registraR           : in std_logic;
		contaT	            : in std_logic;
    zeraT               : in std_logic;
		seletor_leds		    : in std_logic;
    contaP              : in std_logic;
    zeraP               : in std_logic;
    registra_modo       : in std_logic;
    -------------------------------------
		igual               : out std_logic;
		fim_jogo     	 	: out std_logic; -- novo sinal: saida do contador de rodada
		jogada_feita 	 	: out std_logic;
    fim_tempo	 		  : out std_logic;
		fim_espera      : out std_logic;
    modo_escrita    : out std_logic;
    -------------------------------------
		db_tem_jogada	 	: out std_logic; 
		db_contagem  	 	: out std_logic_vector (5 downto 0);
		db_memoria   	 	: out std_logic_vector (3 downto 0);
		db_chaves    	 	: out std_logic_vector (3 downto 0);
		leds				    : out std_logic_vector (3 downto 0);
    pontuacao       : out std_logic_vector (5 downto 0)
	);
end entity;

architecture estrutural of fluxo_dados is
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

  component ram_64x4 is
    port (
       clk          : in  std_logic;
       endereco     : in  std_logic_vector(5 downto 0);
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
		clock	    : in std_logic;
		zera_as	    : in std_logic;
		zera_s	    : in std_logic;
		conta		: in std_logic;
		Q			: out std_logic_vector(natural(ceil(log2(real(M)))) - 1 downto 0);
		fim		    : out std_logic;
		meio	: out std_logic
	);
  end component;
  
  signal s_endereco        : std_logic_vector (5 downto 0);
  signal s_dado         	 : std_logic_vector (3 downto 0);
  signal s_dado_alternativo: std_logic_vector (3 downto 0);
  signal s_dado_fixo       : std_logic_vector (3 downto 0);
  signal s_not_zera_end    : std_logic;
  signal s_not_escreve  	 : std_logic;
  signal s_chaves       	 : std_logic_vector(3 downto 0);
  signal s_chaveacionada   : std_logic := '0';
  signal modo              : std_logic_vector(1 downto 0);
begin

  -- sinais de controle ativos em alto
  -- sinais dos componentes ativos em baixo
  s_not_escreve  <= not escreveM;

  s_chaveacionada <= chaves(3) or chaves(2) or chaves(1) or chaves(0);
  
  contador_endereco: contador_m
	 generic map (
		M => 63
	 )
	 port map (
		clock => clock,
		zera_as => zeraC,
		zera_s => '0',
		conta => contaC,
		Q => s_endereco,
		fim => fim_jogo,
		meio => open
	 );

  contador_pontuacao: contador_m
	 generic map (
		M => 64
	 )
	 port map (
		clock => clock,
		zera_as => zeraP,
		zera_s => '0',
		conta => contaP,
		Q => pontuacao,
		fim => open,
		meio => open
	 );


  comparador_Chaves_Memoria: comparador_85
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

  memoria_jogada_fixa: entity work.ram_64x4 (ram_mif)  -- usar esta linha para Intel Quartus
  --memoria_jogada_fixa: entity work.ram_64x4 (ram_modelsim) -- usar arquitetura para ModelSim
    port map (
       clk          => clock,
       endereco     => s_endereco,
       dado_entrada => s_chaves,
       we           => '1', -- we ativo em baixo, essa memória nunca é sobrescrita
       ce           => '0',
       dado_saida   => s_dado_fixo
    );
  
  memoria_jogada_alternativa: entity work.ram_64x4 (ram_mif)  -- usar esta linha para Intel Quartus
  --memoria_jogada_alternativa: entity work.ram_64x4 (ram_modelsim) -- usar arquitetura para ModelSim
    port map (
       clk          => clock,
       endereco     => s_endereco,
       dado_entrada => s_chaves,
       we           => s_not_escreve, -- we ativo em baixo
       ce           => '0',
       dado_saida   => s_dado_alternativo
    );

	registrador_jogada: registrador_n
		generic map(N => 4)
		port map (
			clock  => clock,
			clear  => zeraR,
			enable => registraR,
			D      => chaves,
			Q      => s_chaves
		);
  
  registrador_modo: registrador_n
    generic map (N => 2)
    port map (
      clock   => clock,
      clear   => '0',
      enable  => registra_modo,
      D       => seletor_modo,
      Q       => modo
    );
	
  -- Adicionado para a exp4 --
  detector_jogada: edge_detector
    port map (
      clock => clock,
      reset => zeraR,
      sinal => s_chaveacionada,
      pulso => jogada_feita
    );
	 
  contador_tempo: contador_m -- conta passagem de tempo entre jogadas
	 generic map (
		M => 500
	 )
	 port map (
		clock => clock,
		zera_as => zeraT,
		zera_s => '0',
		conta => contaT,
		Q => open,
		fim => fim_tempo,
		meio => open
	 );

  contador_espera: contador_m
	 generic map (
		M => 1000
	 )
	 port map (
		clock   => clock,
		zera_as => zeraT,
		zera_s  => '0',
		conta   => contaT,
		Q       => open,
		fim     => fim_espera,
		meio    => open
	 );

  with modo(1) select
    s_dado <= s_dado_fixo when '1',
              s_dado_alternativo when others;

  db_contagem <= s_endereco;
  db_memoria  <= s_dado;
  db_chaves   <= s_chaves;
  db_tem_jogada <= s_chaveacionada;

  modo_escrita <= modo(0);

  with seletor_leds select 
		leds <= s_dado    when '1',
		        chaves when others;
end architecture estrutural;