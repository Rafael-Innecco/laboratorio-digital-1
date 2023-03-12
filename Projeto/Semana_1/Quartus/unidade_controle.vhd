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
		fim_tempo		: in std_logic;
        fim_espera      : in std_logic;
        modo_escrita    : in std_logic;
        --------------------------------
		-- Sinais de controle
		zeraC      	    : out std_logic;
        contaC     	    : out std_logic;
        ----------
        zeraR       	: out std_logic;
        registraR   	: out std_logic;
        ----------
        zeraP           : out std_logic;
        contaP          : out std_logic;
         ----------
        registra_modo   : out std_logic;
         ----------
        pronto      	: out std_logic;
         ----------
        contaT	        : out std_logic;
        zeraT           : out std_logic;
         ----------
        escreveM        : out std_logic;
         ----------
        seletor_leds    : out std_logic;
		-- Sinais de depuracao 
		db_estado   	: out std_logic_vector(3 downto 0)
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
        inicial         when (
            Eatual = inicial and jogar='0'
        ) else
        inicializa_elem when (
            (Eatual = inicial and jogar = '1') or
            (Eatual = fim and jogar = '1') or
            (Eatual = inicializa_elem and fim_espera = '0')
        ) else
		espera_jogada   when (
            (Eatual = inicializa_elem and (fim_espera = '1' and modo_escrita = '0')) or
            (Eatual = proximo and modo_escrita = '0') or
            (Eatual = espera_jogada and jogada = '0' and fim_tempo = '0')
        ) else
        registra        when Eatual = espera_jogada and jogada='1' else 
        compara         when Eatual = registra else
		espera_escrita  when (
            (Eatual = inicializa_elem and (fim_espera = '1' and modo_escrita = '1')) or
            (Eatual = proximo and modo_escrita = '1') or
            (Eatual = espera_escrita and (jogada = '0' and fim_tempo = '0'))
        ) else
        escreve_jogada  when Eatual = espera_escrita and (jogada = '1' or fim_tempo = '1') else
        acerto          when Eatual = compara and igual = '1' else
        termina_tempo   when (
            (Eatual = compara and ((igual = '0' or jogada = '0') and fim_tempo = '0')) or
            (Eatual = acerto and fim_tempo = '0') or
            (Eatual = escreve_jogada and fim_tempo = '0') or
            (Eatual = termina_tempo and fim_tempo  = '0')
        ) else
        ultima_jogada   when (
            (Eatual = termina_tempo and fim_tempo = '1') or
            (Eatual = escreve_jogada and fim_tempo = '1') or
            (Eatual = acerto and fim_tempo = '1') or
            (Eatual = compara and ((igual = '0' or jogada = '0') and fim_tempo = '1')) or
            (Eatual = espera_jogada and fim_tempo = '1')
        ) else
        proximo         when Eatual = ultima_jogada and fim_jogo = '0' else
        fim             when (
            (Eatual = ultima_jogada and fim_jogo = '1') or
            (Eatual = fim and jogar = '0')
        ) else
        inicial;

    -- logica de saída (maquina de Moore)
    with Eatual select
        zeraC <=            '1' when inicial | inicializa_elem | fim, -- novos estados; 
                            '0' when others;
    with Eatual select
        contaC <=           '1' when proximo,
                            '0' when others;
    with Eatual select
        zeraR <=            '1' when inicial | inicializa_elem | proximo | fim,
                            '0' when others;
    with Eatual select
        registraR <=        '1' when registra | espera_escrita,
                            '0' when others;
    with Eatual select
        contaT <= 	        '1' when espera_jogada | inicializa_elem | espera_escrita | termina_tempo,
						    '0' when others;
    with Eatual select
        zeraT <=            '1' when ultima_jogada,
                            '0' when others;
    with Eatual select
        zeraP <=            '1' when inicializa_elem,
                            '0' when others;
    with Eatual select
        contaP <=           '1' when acerto,
                            '0' when others;
    with Eatual select
        pronto <=           '1' when fim,
                	        '0' when others;
    with Eatual select
        escreveM <=         '1' when escreve_jogada,
                            '0' when others;
    with Eatual select
        registra_modo <=    '1' when inicial | fim,
                            '0' when others;
    with Eatual select
        seletor_leds <=     '1' when inicializa_elem,
                            '0' when others;
	--
    -- saida de depuracao (db_estado)
    with Eatual select
        db_estado <= "0000" when inicial,           -- 0
                     "0001" when inicializa_elem,   -- 1
                     "0010" when espera_jogada,     -- 2
                     "0011" when registra,          -- 3
                     "0100" when compara,           -- 4
					 "0101" when acerto,            -- 5
                     "0110" when espera_escrita,    -- 6
                     "0111" when escreve_jogada,    -- 7
                     "1000" when termina_tempo,     -- 8
                     "1001" when ultima_jogada,     -- 9
                     "1010" when proximo,           -- A
                     "1111" when fim,               -- F
                     "1110" when others;            -- E
end architecture fsm;