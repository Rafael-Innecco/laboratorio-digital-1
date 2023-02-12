--------------------------------------------------------------------
-- Arquivo   : circuito_exp4.vhd
-- Projeto   : Experiencia 4 - Desenvolvimento de Projeto de Circuitos Digitais em FPGA
--------------------------------------------------------------------
-- Descricao : unidade de controle 
--
--             1) codificação VHDL (maquina de Moore)
--
--             2) definicao de valores da saida de depuracao
--                db_estado
-- 
--------------------------------------------------------------------
-- Revisoes  :
--  Data        Versao  Autor           Descricao
--  01/02/2023  1.0     Rafael Innecco  Versão inicial
--  08/02/2023  1.1     Rafael Innecco  Versao desafio
--------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity circuito_jogo_base is -- novo nome de entidade
    port (
        clock           	    : in std_logic;
        reset           		: in std_logic;
        jogar       		    : in std_logic; -- novo nome: iniciar -> jogar
        botoes        		    : in std_logic_vector (3 downto 0); -- novo nome: chaves -> botoes
        leds           			: out std_logic_vector (3 downto 0);
		pronto          		: out std_logic;
        ganhou          		: out std_logic; -- novo nome: acertou -> ganhou
        perdeu           		: out std_logic;     
        db_clock                : out std_logic;
		db_tem_jogada    		: out std_logic;
		db_jogada_correta       : out std_logic; -- novo nome: db_igual -> db_jogada_correta
        db_enderecoIgualRodada  : out std_logic; -- nova saida
		db_timeout				: out std_logic;
		db_contagem     		: out std_logic_vector (6 downto 0);
        db_memoria      		: out std_logic_vector (6 downto 0);
        db_jogadafeita 			: out std_logic_vector (6 downto 0);
		db_rodada       		: out std_logic_vector (6 downto 0); -- nova saida
		db_estado       		: out std_logic_vector (6 downto 0)               
    );
end entity;

architecture estrutural of circuito_jogo_base is -- componente alterado
    component fluxo_dados
        port (
			clock        	    : in  std_logic;
			zeraC_End           : in  std_logic; -- novo nome: zeraC -> zeraC_End
			contaC_End   	    : in  std_logic; -- novo nome: contaC -> contaC_End
			zeraC_Rod    	 	: in std_logic;  -- novo sinal: entrada do contador de rodadas
			contaC_Rod   	    : in std_logic;  -- novo sinal: entrada do contador de rodadas
			escreveM     		: in  std_logic;
			zeraR         		: in  std_logic;
			registraR           : in std_logic;
			chaves              : in  std_logic_vector (3 downto 0);
			contaTempo	        : in std_logic; 
			igual               : out std_logic;
			enderecoIgualRodada : out std_logic; -- novo sinal: saida do comparador endereco x rodada - Funcao: fim_rodada
			fim_jogo     	 	: out std_logic; -- novo sinal: saida do contador de rodada
			jogada_feita 	 	: out std_logic;
			db_tem_jogada	 	: out std_logic; 
			db_contagem  	 	: out std_logic_vector (3 downto 0);
			db_memoria   	 	: out std_logic_vector (3 downto 0);
			db_chaves    	 	: out std_logic_vector (3 downto 0);
			db_rodada    		: out std_logic_vector (3 downto 0); -- novo sinal de depuracao
			fimTempo	 		: out std_logic 
        );
    end component;
	
    component unidade_controle  -- componente alterado
        port (
			clock       	: in std_logic;
			-- Sinais de condicao
			reset       	: in std_logic;
			jogar        	: in std_logic; -- novo nome: iniciar -> jogar
			fim_jogo       	: in std_logic; -- novo nome e funcao: fim -> fim_jogo, identifica momento em que a ultima rodada eh concluida
			jogada      	: in std_logic;
			igual       	: in std_logic;
			fimTempo		: in std_logic;
			fim_rodada      : in std_logic; -- novo sinal: identifica fim de uma rodada: contador antigo igual ao da rodada.
			-- Sinais de controle
			zeraC_End      	: out std_logic; -- novo nome: sinal de controle do contador de endereco da memoria
			contaC_End     	: out std_logic; -- novo nome: sinal de controle do contador de endereco da memoria
			zeraC_Rod       : out std_logic; -- novo sinal de controle: zera contador de rodada
			contaC_Rod      : out std_logic; -- novo sinal de controle: incrementa contador de rodada
			zeraR       	: out std_logic;
			registraR   	: out std_logic;
			ganhou       	: out std_logic; -- novo nome: acertou -> ganhou
			perdeu       	: out std_logic; -- novo nome: errou -> perdeu
			pronto      	: out std_logic;
			contaTempo	    : out std_logic;
			-- Sinais de depuracao 
			db_estado   	: out std_logic_vector(3 downto 0);
			db_timeout	    : out std_logic	
        );
    end component;

    component hexa7seg
        port (
            hexa : in  std_logic_vector(3 downto 0);
            sseg : out std_logic_vector(6 downto 0)
        );
    end component;

	    signal db_mem_hex, db_cont_hex, db_jogada_hex, db_estado_hex, db_rodada_hex : std_logic_vector(3 downto 0) := "0000"; -- novo sinal
    signal zeraC_End, contaC_End, zeraR, registraR, igual, fim_jogo, jogada_feita   : std_logic := '0'; -- novos nomes
	signal zeraC_Rod, contaC_Rod    : std_logic; -- novos sinais
	signal contaTempo, fimTempo 	: std_logic;
	signal enderecoIgualRodada      : std_logic; -- Novo sinal intermediario
begin

    fluxo_dadosFD: fluxo_dados -- Instanciacao modificada
        port map (
            clock 	            =>  clock,
			zeraC_End      	 	=>  zeraC_End,
            contaC_End   	    =>  contaC_End,
            zeraC_Rod			=>  zeraC_Rod,
			contaC_Rod			=>  contaC_Rod,
			escreveM       	 	=>  '0',
            zeraR       	    =>  zeraR,
            registraR   	    =>  registraR,
            chaves      	    =>  botoes,
			contaTempo			=>  contaTempo,
            igual          		=>  igual,
            enderecoIgualRodada =>  enderecoIgualRodada,
			fim_jogo            =>  fim_jogo,
            jogada_feita        =>  jogada_feita,
            db_tem_jogada 	    =>  db_tem_jogada,
            db_contagem    		=>  db_cont_hex,
            db_memoria     		=>  db_mem_hex,
            db_chaves      		=>  db_jogada_hex,
			db_rodada           =>  db_rodada_hex,
			fimTempo			=>  fimTempo
        );
    --
	
    unidade_controleUC: unidade_controle --Instanciacao modificada
        port map (
            clock        => clock,
            reset        => reset,
            jogar       => jogar,
            fim_jogo     => fim_jogo,
            jogada       => jogada_feita,
            igual        => igual,
			fimTempo     => fimTempo,
			fim_rodada   => enderecoIgualRodada,
            zeraC_End    => zeraC_End,
            contaC_End   => contaC_End,
            zeraC_Rod    => zeraC_Rod,
			contaC_Rod   => contaC_Rod,
			zeraR        => zeraR,
            registraR    => registraR,
            ganhou       => ganhou,
            perdeu       => perdeu,
            pronto       => pronto,
            contaTempo	 => contaTempo,
			db_estado    => db_estado_hex,
			db_timeout	 => db_timeout
				
        );
    --

    hex7jogada: hexa7seg
        port map (
            hexa => db_jogada_hex,
            sseg => db_jogadafeita
        );
    --

    hex7contagem: hexa7seg
        port map (
            hexa => db_cont_hex,
            sseg => db_contagem
        );
    --

    hex7memoria: hexa7seg
        port map (
            hexa => db_mem_hex,
            sseg => db_memoria
        );
    --
	
	hex7rodada: hexa7seg -- nova instanciacao do display
		port map(
			hexa => db_rodada_hex,
			sseg => db_rodada
		);
	--
	
    hex7estado: hexa7seg
        port map (
            hexa => db_estado_hex,
			sseg => db_estado
        );
    --
    
    db_clock <= clock;

    leds <= db_mem_hex;

    db_jogada_correta <= igual;
	
	db_enderecoIgualRodada <= enderecoIgualRodada;
end architecture estrutural;