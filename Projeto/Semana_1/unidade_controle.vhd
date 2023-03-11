--------------------------------------------------------------------
-- Arquivo   : unidade_controle.vhd
-- Projeto   : Projeto da disciplina
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
-- 14/02/2023   1.2     João Arroyo     Versão exp_5
-- 15/02/2023   1.2.1   Rafael Innecco  Versão desafio exp_5
-- 11/03/2023   2.0     Rafael Innecco  Modificações para o projeto da disciplina
--------------------------------------------------------------------
--

library ieee;
use ieee.std_logic_1164.all;

entity unidade_controle is
    port (
        clock       	: in std_logic;
        -- Sinais de condicao
		reset       	: in std_logic;
        jogar        	: in std_logic;
        fim_jogo       	: in std_logic;
        jogada      	: in std_logic;
        igual       	: in std_logic;
		fimTempo		: in std_logic;
		--fim_rodada    : in std_logic; -- novo sinal: identifica fim de uma rodada: contador antigo igual ao da rodada.
        fim_espera      : in std_logic;
        modo_escrita    : in std_logic;
		-- Sinais de controle
		zeraC_End      	: out std_logic; -- novo nome: sinal de controle do contador de endereco da memoria
        contaC_End     	: out std_logic; -- novo nome: sinal de controle do contador de endereco da memoria
		--zeraC_Rod       : out std_logic; -- novo sinal de controle: zera contador de rodada
		--contaC_Rod      : out std_logic; -- novo sinal de controle: incrementa contador de rodada
        zeraR       	: out std_logic;
        registraR   	: out std_logic;
        zeraP           : out std_logic;
        contaP          : out std_logic;
        registra_modo   : out std_logic;
        --ganhou       	: out std_logic; -- novo nome: acertou -> ganhou
        --perdeu       	: out std_logic; -- novo nome: errou -> perdeu
        pronto      	: out std_logic;
        contaT	        : out std_logic;
        zeraT           : out std_logic;
        escreveM        : out std_logic;
        seletor_leds    : out std_logic;
		-- Sinais de depuracao 
		db_estado   	: out std_logic_vector(3 downto 0);
		--db_timeout	    : out std_logic	
    );
end entity;

architecture fsm of unidade_controle is
    type t_estado is (
                        inicial, inicializa_elem,
  	                    espera_jogada, registra, compara, acerto,
                        espera_escrita, escreve_jogada,
                        termina_tempo, ultima_jogada, proximo, fim
                    ); -- novo estado para escrita
    signal Eatual, Eprox: t_estado;
begin

    -- memoria de estado
    process (clock,reset)
    begin
        if reset='1' then
            Eatual <= inicial;
        elsif clock'event and clock = '1' then
            Eatual <= Eprox; 
        end if;
    end process;

    -- logica de proximo estado:
	-- Modificada
    Eprox <=
        inicial         when  (
            Eatual = inicial and jogar='0'
        ) else
        inicializa_elem when  (
            (Eatual = inicial and jogar = '1') or
            (Eatual = fim and jogar = '1') or
            (Eatual = inicializa_elem and fim_espera = '0')
        ) else
		espera_jogada   when  (
            (Eatual = inicializa_elem and (fim_espera = '1' and modo_escrita = '0')) or
            (Eatual = pronto and modo_escrita = '0')
        ) else
        registra        when  Eatual = espera and (jogada='1' or fimTempo = '1') else 
        compara         when  Eatual = registra else
        proximo         when  Eatual = ultima_jogada and fim_jogo = '0' else
        ultima_rodada   when  Eatual=compara and fim_rodada='1' and igual = '1' else -- fim -> fim_rodada / novo estado
		espera_escrita  when  (Eatual=ultima_rodada and fim_jogo='0') or (Eatual = espera_escrita and jogada = '0' and fimTempo  ='0') else
        escreve_jogada  when  Eatual=espera_escrita and jogada='1' and fimTempo='0' else
        proxima_rodada  when  Eatual = escreve_jogada   else
		fim_erro        when  (Eatual=compara and igual = '0') or (Eatual=fim_erro and jogar='0') else -- iniciar -> jogar
        fim_certo       when  (Eatual=ultima_rodada and fim_jogo='1')  or  (Eatual=fim_certo and jogar = '0') else -- igual = '1' foi suprimido da 1.a condicao + mudanca do estado inicial da transicao
        inicial;

    -- logica de saída (maquina de Moore)
	-- Modificada	
	with Eatual select
        zeraC_End <=    '1' when inicial | inicio_rodada | fim_timeout | fim_erro, -- novos estados; 
                        '0' when others;
	
	with Eatual select
		zeraC_Rod <=    '1' when fim_timeout | fim_erro | fim_certo | inicial, 
				'0' when others;
    	with Eatual select
        	zeraR <=        '1' when inicial | inicializa_elem,
                        	'0' when others;
    	
	with Eatual select
        	registraR <=    '1' when registra | espera_escrita,
                        	'0' when others;

    with Eatual select
    	contaC_End <=   '1' when proximo | ultima_rodada,
                    	'0' when others;
						
	with Eatual select 
		contaC_Rod <=	'1' when proxima_rodada,
				'0' when others;
    with Eatual select
        pronto <=   '1' when fim_certo | fim_erro | fim_timeout,
                	'0' when others;
								
	with Eatual select
			contaT <= 	'1' when espera | inicializa_elem | espera_escrita,
							'0' when others;
    with Eatual select
			db_timeout <=	'1' when fim_timeout,
							'0' when others;

    with Eatual select
            escreveM <= '1' when escreve_jogada,
                        '0' when others;

    with Eatual select
            seletor_leds <= '1' when inicializa_elem,
                            '0' when others;
    -- saida de depuracao (db_estado)
    with Eatual select
        db_estado <= "0000" when inicial,           -- 0
                     "0001" when inicializa_elem,   -- 1
					 "0010" when inicio_rodada,     -- 2 Novo estado 
                     "0011" when espera,            -- 3 Codigo alterado
                     "0100" when registra,          -- 4
                     "0101" when compara,           -- 5
                     "0110" when proximo,           -- 6
					 "0111" when ultima_rodada,     -- 7 Novo estado
					 "1000" when proxima_rodada,    -- 8 Novo estado
                     "1001" when espera_escrita,    -- 9
					 "1010" when escreve_jogada,    -- A
                     "1101" when fim_erro,          -- B
                     "1100" when fim_certo,         -- C
                     "1101" when fim_timeout,       -- A
                     "1111" when others;            -- F
end architecture fsm;