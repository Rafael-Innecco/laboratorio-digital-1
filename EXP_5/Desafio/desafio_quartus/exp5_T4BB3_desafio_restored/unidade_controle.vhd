--------------------------------------------------------------------
-- Arquivo   : unidade_controle.vhd
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
--

library ieee;
use ieee.std_logic_1164.all;

entity unidade_controle is
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
        espera_inicializacao : in std_logic; -- NOVO
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
        escreveM        : out std_logic;
        seletor_leds    : out std_logic;
		-- Sinais de depuracao 
		db_estado   	: out std_logic_vector(3 downto 0);
		db_timeout	    : out std_logic	
    );
end entity;

architecture fsm of unidade_controle is
    type t_estado is (inicial, inicializa_elem, inicio_rodada, ultima_rodada, proxima_rodada,
  	                  espera, registra, compara, proximo, fim_erro, fim_certo, fim_timeout,
                      espera_escrita, escreve_jogada); -- novo estado para escrita
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
        inicial         when  Eatual=inicial and jogar='0' else -- iniciar -> jogar
        inicializa_elem when  ((Eatual=inicial or Eatual=fim_certo or Eatual=fim_erro or Eatual=fim_timeout) and jogar='1') 
								or (Eatual=inicializa_elem and espera_inicializacao = '0') else --iniciar -> pronto
        inicio_rodada   when  (Eatual=inicializa_elem and espera_inicializacao = '1') or Eatual=proxima_rodada else -- novo estado
		espera          when  (Eatual=inicio_rodada) or (Eatual=proximo) or (Eatual = espera and jogada='0' and fimTempo='0') else -- mudanca na transicao que agora vem de inicio_rodada
		fim_timeout		when  ((Eatual=espera or Eatual=espera_escrita) and fimTempo = '1') or (Eatual=fim_timeout and jogar='0') else -- iniciar -> jogar
        registra        when  (Eatual=espera and jogada='1') else 
        compara         when  Eatual=registra else
        proximo         when  Eatual=compara and fim_rodada='0' and igual = '1' else -- fim -> fim_rodada
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
        zeraC_End <=    '1' when inicial | inicio_rodada, -- novos estados; 
                        '0' when others;
	
	with Eatual select
		zeraC_Rod <=    '1' when fim_timeout | fim_erro | fim_certo, 
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
        ganhou <=   '1' when fim_certo,
                    '0' when others;
    
    with Eatual select
        perdeu <=   '1' when fim_erro | fim_timeout,
                    '0' when others;
								
	with Eatual select
			contaTempo <= 	'1' when espera | inicializa_elem,
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