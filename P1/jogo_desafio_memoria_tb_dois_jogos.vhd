--------------------------------------------------------------------------
-- Arquivo   : circuito_exp4_tb_modelo.vhd
-- Projeto   : Experiencia 04 - Desenvolvimento de Projeto de
--                              Circuitos Digitais com FPGA
--------------------------------------------------------------------------
-- Descricao : modelo de testbench para simulação com ModelSim
--
--             implementa um Cenário de Teste do circuito
--             com 3 jogadas certas e erro na quarta jogada
--------------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     01/02/2020  1.0     Edson Midorikawa  criacao
--     27/01/2021  1.1     Edson Midorikawa  revisao
--     27/01/2022  1.2     Edson Midorikawa  revisao e adaptacao
--     04/02/2023  1.3     Rafael Innecco    adaptacao
--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

-- entidade do testbench
entity jogo_desafio_memoria_tb_dois_jogos is
end entity;

architecture tb of jogo_desafio_memoria_tb_dois_jogos is

  -- Componente a ser testado (Device Under Test -- DUT)
    component jogo_desafio_memoria
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
  end component;
  
  
  ---- Declaracao de sinais de entrada para conectar o componente
  signal clk_in     : std_logic := '0';
  signal rst_in     : std_logic := '0';
  signal jogar_in   : std_logic := '0';
  signal botoes_in  : std_logic_vector(3 downto 0) := "0000";

  ---- Declaracao dos sinais de saida
  signal jogada_correta_out  : std_logic := '0';
  signal ganhou_out          : std_logic := '0';
  signal perdeu_out          : std_logic := '0';
  signal pronto_out          : std_logic := '0';
  signal leds_out            : std_logic_vector(3 downto 0) := "0000";
  signal clock_out           : std_logic := '0';
  signal tem_jogada_out      : std_logic := '0';
  signal endereco_igual_rodada_out  : std_logic := '0';
  signal rodada_out          : std_logic_vector(6 downto 0) := "0000000";
  signal contagem_out        : std_logic_vector(6 downto 0) := "0000000";
  signal memoria_out         : std_logic_vector(6 downto 0) := "0000000";
  signal estado_out          : std_logic_vector(6 downto 0) := "0000000";
  signal jogada_out          : std_logic_vector(6 downto 0) := "0000000";
  signal timeout_out         : std_logic;
  -- Configurações do clock
  signal keep_simulating: std_logic := '0'; -- delimita o tempo de geração do clock
  constant clockPeriod : time := 20 ns;     -- frequencia 50MHz
  signal caso : integer := 0;
  
begin
  -- Gerador de clock: executa enquanto 'keep_simulating = 1', com o período especificado. 
  -- Quando keep_simulating=0, clock é interrompido, bem como a simulação de eventos
  clk_in <= (not clk_in) and keep_simulating after clockPeriod/2;
  
  ---- DUT para Simulacao
  dut: jogo_desafio_memoria
       port map
       (
          clock          		  => clk_in,
          reset          		  => rst_in,
          jogar          		  => jogar_in,
          botoes         		  => botoes_in,
          ganhou         	 	  => ganhou_out,
          perdeu         	 	  => perdeu_out,
          pronto                  => pronto_out,
          leds           		  => leds_out,
          db_jogada_correta 	  => jogada_correta_out,
		  db_enderecoIgualRodada  => endereco_igual_rodada_out,
          db_contagem     	      => contagem_out,
          db_memoria      		  => memoria_out,
          db_estado       	 	  => estado_out,
          db_jogadafeita  		  => jogada_out,  
          db_clock        		  => clock_out,
          db_tem_jogada   		  => tem_jogada_out,
		  db_rodada               => rodada_out,
		  db_timeout      		  => timeout_out
       );
 
  ---- Gera sinais de estimulo para a simulacao
  -- Cenario de Teste : acerta as primeiras 4 jogadas
  --                    e erra a 5a jogada
  stimulus: process is
  begin

    -- inicio da simulacao
    caso <= 0;
    assert false report "inicio da simulacao" severity note;
    keep_simulating <= '1';  -- inicia geracao do sinal de clock

    -- gera pulso de reset (1 periodo de clock)
    caso <= 1;
    rst_in <= '1';
    wait for clockPeriod;
    rst_in <= '0';

    -- espera para início dos testes (10 ciclos de clock)
    caso <= 2;
    wait for 10*clockPeriod;

    -- pulso do sinal de JOGAR (muda na borda de descida do clock)
    caso <= 3;
    wait until falling_edge(clk_in);
    jogar_in <= '1';
    wait for 2200 * clockPeriod;
    jogar_in <= '0';

    -- Cenario de Teste - acerta as 4 primeiras jogadas e erra a 5a jogada

    ---- jogada #1 rodada #1 (chaves=0001 e 5 clocks de duracao)
    caso <= 4;
    botoes_in <= "0001";
    wait for 5*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
 
    ---- guarda valor na memória (chaves=0001 e 7 clocks de duracao)
    caso <= 5;
    botoes_in <= "0001";
    wait for 7*clockPeriod;
    botoes_in <= "0000";
    -- espera entre jogadas
    wait for 10*clockPeriod;  

    ---- jogada #1 rodada #2 (chaves=0001 e 15 clocks de duracao)
    caso <= 6;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
 
	---- jogada #2 rodada #2 (chaves=0001 e 15 clocks de duracao)
    caso <= 7;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
 
	---- guarda valor na memória (chaves=0001 e 15 clocks de duracao)
    caso <= 8;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
	
	---- jogada #1 rodada #3 (chaves=0001 e 15 clocks de duracao)
    caso <= 9;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
	
	---- jogada #2 rodada #3 (chaves=0001 e 15 clocks de duracao)
    caso <= 10;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
	
	---- jogada #3 rodada #3 (chaves=0001 e 15 clocks de duracao)
    caso <= 11;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    ---- guarda valor na memória (chaves=0001 e 15 clocks de duracao)
    caso <= 12;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
	
	---- jogada #1 rodada #4 (chaves=0001 e 15 clocks de duracao)
    caso <= 13;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
	
	---- jogada #2 rodada #4 (jogada errada: chaves=0010 e 15 clocks de duracao)
    caso <= 14;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    -- Espera entre jogos
    caso <= 15;
    wait for 10*clockPeriod;

    -- pulso do sinal de JOGAR (muda na borda de descida do clock)
    caso <= 16;
    wait until falling_edge(clk_in);
    jogar_in <= '1';
    wait for 2200 * clockPeriod;
    jogar_in <= '0';

    -- Cenario de Teste - acerta as 4 primeiras jogadas e erra a 5a jogada

    ---- jogada #1 rodada #1 (chaves=0001 e 5 clocks de duracao)
    caso <= 17;
    botoes_in <= "0001";
    wait for 5*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
 
    ---- guarda valor na memória (chaves=0001 e 7 clocks de duracao)
    caso <= 18;
    botoes_in <= "0001";
    wait for 7*clockPeriod;
    botoes_in <= "0000";
    -- espera entre jogadas
    wait for 10*clockPeriod;  

    ---- jogada #1 rodada #2 (chaves=0001 e 15 clocks de duracao)
    caso <= 19;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
 
	---- jogada #2 rodada #2 (chaves=0001 e 15 clocks de duracao)
    caso <= 20;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
 
	---- guarda valor na memória (chaves=0001 e 15 clocks de duracao)
    caso <= 21;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
	
	---- jogada #1 rodada #3 (chaves=0001 e 15 clocks de duracao)
    caso <= 22;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
	
	---- jogada #2 rodada #3 (chaves=0001 e 15 clocks de duracao)
    caso <= 23;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
	
	---- jogada #3 rodada #3 (chaves=0001 e 15 clocks de duracao)
    caso <= 24;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    ---- guarda valor na memória (chaves=0001 e 15 clocks de duracao)
    caso <= 25;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
	
	---- jogada #1 rodada #4 (chaves=0001 e 15 clocks de duracao)
    caso <= 26;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
	
	---- jogada #2 rodada #4 (jogada errada: chaves=0010 e 15 clocks de duracao)
    caso <= 27;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --espera por timeout
    caso <= 28;
    wait for 5100*clockPeriod;
 
    ---- final do testbench
    assert false report "fim da simulacao" severity note;
    keep_simulating <= '0';
	
 
    ---- final do testbench
    assert false report "fim da simulacao" severity note;
    keep_simulating <= '0';
    
    wait; -- fim da simulação: processo aguarda indefinidamente
  end process;


end architecture;