--------------------------------------------------------------------
-- Arquivo   : jogo_desafio_ritmo.vhd
-- Projeto   : Projeto da disciplina
--------------------------------------------------------------------
-- Descricao : Circuito do projeto da disciplina, baseado no circuito
--			   da experiência 6
-- 
--------------------------------------------------------------------
-- Revisoes  :
--  Data        Versao  Autor           Descricao
--  11/02/2023  1.0     João Arroyo     Versão inicial
--	11/03/2023	2.0		Rafael Innecco	Modificações iniciais do projeto
--	17/03/2023	2.1		Rafael Innecco	Mudança para controle de pontuação
--------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity jogo_desafio_ritmo is -- novo nome de entidade
    port (
        clock           	: in std_logic;
        reset           	: in std_logic;
        jogar       		: in std_logic; -- novo nome: iniciar -> jogar
        botoes        		: in std_logic_vector (3 downto 0); -- novo nome: chaves -> botoes
		seletor_modo		: in std_logic_vector (1 downto 0); -- seletor modo = XY => X = seletor de memória; Y = seletor de escrita
		------------------------
        leds           			: out std_logic_vector (15 downto 0);
		pronto          		: out std_logic;
		pontuacao				: out std_logic_vector (20 downto 0); -- ocupa três displays de sete segmentos
		------------------------     
        db_clock				: out std_logic;
		db_tem_jogada    		: out std_logic;
		db_jogada_correta       : out std_logic;
		db_contagem				: out std_logic_vector (13 downto 0); -- Ocupa dois displays de sete segmentos 
        db_memoria      		: out std_logic_vector (6 downto 0);
        db_jogadafeita 			: out std_logic_vector (6 downto 0);
		db_estado       		: out std_logic_vector (6 downto 0)               
    );
end entity;

architecture estrutural of jogo_desafio_ritmo is -- componente alterado
    component fluxo_dados
        port (
			clock        	    : in std_logic;
			chaves              : in std_logic_vector (3 downto 0);
			seletor_modo		: in std_logic_vector (1 downto 0);
			-----------------------
			zeraC           	: in std_logic;
			contaC   	    	: in std_logic;
			carregaC			: in std_logic;
			escreveM     		: in std_logic;
			zeraR         		: in std_logic;
			registraR           : in std_logic;
			contaT	        	: in std_logic;
			contaT2				: in std_logic; 
			zeraT				: in std_logic;
			atualizaP			: in std_logic;
			diminuiP_jogada		: in std_logic;
			resetaP_jogada		: in std_logic;
			zeraP				: in std_logic;
			registra_modo		: in std_logic;
			-----------------------
			igual               : out std_logic;
			fim_jogo     	 	: out std_logic;
			jogada_feita 	 	: out std_logic;
			fim_tempo			: out std_logic;
			fim_tempo_2			: out std_logic;
			fim_espera			: out std_logic;
			modo_escrita		: out std_logic;
			-----------------------
			db_tem_jogada	 	: out std_logic; 
			db_contagem  	 	: out std_logic_vector (6 downto 0);
			db_memoria   	 	: out std_logic_vector (3 downto 0);
			db_chaves    	 	: out std_logic_vector (3 downto 0);
			leds				: out std_logic_vector (15 downto 0);
			pontuacao_dec		: out std_logic_vector (11 downto 0)
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
			fim_tempo		: in std_logic;
			fim_tempo_2		: in std_logic;
			fim_espera		: in std_logic;
			modo_escrita	: in std_logic;
			--------------------------------
			-- Sinais de controle
			zeraC      		: out std_logic; 
			contaC     		: out std_logic;
			carregaC		: out std_logic;
			------------
			zeraR       	: out std_logic;
			registraR   	: out std_logic;
			------------
			zeraP			: out std_logic;
			atualizaP		: out std_logic;
			diminuiP_jogada	: out std_logic;
			resetaP_jogada	: out std_logic;
			------------
			registra_modo	: out std_logic;
			------------
			pronto      	: out std_logic;
			------------
			contaT			: out std_logic;
			contaT2			: out std_logic;
			zeraT			: out std_logic;
			------------
			escreveM		: out std_logic;
			------------
			-- Sinais de depuracao 
			db_estado   	: out std_logic_vector(3 downto 0)
        );
    end component;

    component hexa7seg
        port (
            hexa : in  std_logic_vector(3 downto 0);
            sseg : out std_logic_vector(6 downto 0)
        );
    end component;

	signal db_mem_hex, db_jogada_hex, db_estado_hex: std_logic_vector(3 downto 0) := "0000"; -- novo sinal
    signal db_cont_hex	: std_logic_vector(6 downto 0);
	signal pontuacao_hex: std_logic_vector(11 downto 0);
	signal db_cont_display1, db_cont_display2, pontuacao_display1, pontuacao_display2, pontuacao_display3: std_logic_vector (6 downto 0);
	signal db_contagem_hex_parte2, pontuacao_hex_parte3: std_logic_vector (3 downto 0);
	signal zeraC, contaC, zeraR, registraR	: std_logic := '0';
	signal zeraP, atualizaP, registra_modo	: std_logic := '0';
	signal diminuiP_jogada, resetaP_jogada	: std_logic := '0';
	signal igual, jogada_feita 	: std_logic := '0';
	signal fim_jogo, fim_espera				: std_logic	:= '0';
	signal modo_escrita						: std_logic;
	signal contaT, zeraT, fim_tempo			: std_logic;
	signal contaT2, fim_tempo_2				: std_logic;
	signal escreveM, carregaC				: std_logic;
	signal not_botoes   : std_logic_vector(3 downto 0);
begin
	
	not_botoes <= not botoes;
	
    fluxo_dadosFD: fluxo_dados -- Instanciacao modificada
        port map (
            clock 	            =>  clock,
			chaves      	    =>  not_botoes,
			seletor_modo		=> seletor_modo,
			---------------------------
			zeraC      	 		=>  zeraC,
            contaC   	    	=>  contaC,
			carregaC			=> carregaC,
			escreveM       	 	=>  escreveM,
            zeraR       	    =>  zeraR,
            registraR   	    =>  registraR,
			contaT				=>  contaT,
			contaT2				=> contaT2,
			zeraT				=> zeraT,
			atualizaP			=> atualizaP,
			diminuiP_jogada		=> diminuiP_jogada,
			resetaP_jogada		=> resetaP_jogada,
			zeraP				=> zeraP,
			registra_modo		=> registra_modo,
			--------------------------
			igual          		=>  igual,
			fim_jogo            =>  fim_jogo,
            jogada_feita        =>  jogada_feita,
			fim_tempo			=>  fim_tempo,
			fim_tempo_2			=> fim_tempo_2,
			fim_espera			=> fim_espera,
			modo_escrita		=> modo_escrita,
			---------------------------
            db_tem_jogada 	    =>  db_tem_jogada,
            db_contagem    		=>  db_cont_hex,
            db_memoria     		=>  db_mem_hex,
            db_chaves      		=>  db_jogada_hex,
			leds 				=> leds,
			pontuacao_dec			=> pontuacao_hex
        );
    --
	
    unidade_controleUC: unidade_controle --Instanciacao modificada
        port map (
            clock        	=> clock,
            reset        	=> reset,
            jogar       	=> jogar,
            fim_jogo     	=> fim_jogo,
            jogada       	=> jogada_feita,
            igual        	=> igual,
			fim_tempo     	=> fim_tempo,
			fim_tempo_2		=> fim_tempo_2,
			fim_espera		=> fim_espera,
			modo_escrita	=> modo_escrita,
			---------------------
            zeraC    		=> zeraC,
            contaC   		=> contaC,
			carregaC			=> carregaC,
			zeraR        	=> zeraR,
            registraR    	=> registraR,
			zeraP			=> zeraP,
			atualizaP		=> atualizaP,
			diminuiP_jogada	=>	diminuiP_jogada,
			resetaP_jogada	=> resetaP_jogada,
			registra_modo	=> registra_modo,
            pronto       	=> pronto,
            contaT	 		=> contaT,
			contaT2			=> contaT2,
			zeraT			=> zeraT,
			escreveM	 	=> escreveM,
			db_estado    	=> db_estado_hex
        );
    --

    hex7jogada: hexa7seg
        port map (
            hexa => db_jogada_hex,
            sseg => db_jogadafeita
        );
    --
	
    hex7contagem1: hexa7seg
        port map (
            hexa => db_cont_hex(3 downto 0),
            sseg => db_cont_display1
       );
	db_contagem_hex_parte2 <= "0" & db_cont_hex(6 downto 4);
	hex7contagem2: hexa7seg
        port map (
            hexa => db_contagem_hex_parte2,
            sseg => db_cont_display2
       );
	db_contagem <= db_cont_display2 & db_cont_display1;

	hex7pontuacao1: hexa7seg
        port map (
            hexa => pontuacao_hex(3 downto 0),
            sseg => pontuacao(6 downto 0)
       );
	hex7pontuacao2: hexa7seg
        port map (
            hexa => pontuacao_hex(7 downto 4),
            sseg => pontuacao(13 downto 7)
       );
	hex7pontuacao3: hexa7seg
        port map (
            hexa => pontuacao_hex(11 downto 8),
            sseg => pontuacao(20 downto 14)
       );
	--
    hex7memoria: hexa7seg
        port map (
            hexa => db_mem_hex,
            sseg => db_memoria
        );
	
    hex7estado: hexa7seg
        port map (
            hexa => db_estado_hex,
			sseg => db_estado
        );
    --
    
    db_clock <= clock;

    db_jogada_correta <= igual;
end architecture estrutural;