--------------------------------------------------------------------------
-- Arquivo   : circuito_exp4_tb_modelo.vhd
-- Projeto   : Experiencia 04 - Desenvolvimento de Projeto de
--                              Circuitos Digitais com FPGA
--------------------------------------------------------------------------
-- Descricao : modelo de testbench para simulação com ModelSim
--
--             implementa um Cenário de Teste do circuito
--             com 16 jogadas certas
--------------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     01/02/2020  1.0     Edson Midorikawa  criacao
--     27/01/2021  1.1     Edson Midorikawa  revisao
--     27/01/2022  1.2     Edson Midorikawa  revisao e adaptacao
--     04/02/2023  2.0     Rafael Innecco    Adaptação para outro cenário
--------------------------------------------------------------------------
-- Especificações do jogo:
-- 60 jogadas em 30 segundos (0,5 segundo por jogada = 500 clk_period)


library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

-- entidade do testbench
entity jogo_desafio_ritmo_tb_modo_base is
end entity;

architecture tb of jogo_desafio_ritmo_tb_modo_base is

  -- Componente a ser testado (Device Under Test -- DUT)
  component jogo_desafio_ritmo
         port (
        clock               : in std_logic;
        reset               : in std_logic;
        jogar               : in std_logic; -- novo nome: iniciar -> jogar
        botoes              : in std_logic_vector (3 downto 0); -- novo nome: chaves -> botoes
        seletor_modo        : in std_logic_vector (1 downto 0); -- seletor modo = XY => X = seletor de memória; Y = seletor de escrita
        ------------------------
        leds                : out std_logic_vector (3 downto 0);
        pronto              : out std_logic;
        pontuacao           : out std_logic_vector (6 downto 0);
		--ganhou            : out std_logic; -- novo nome: acertou -> ganhou
        --perdeu            : out std_logic;
        ------------------------
        db_clock            : out std_logic;
        db_tem_jogada       : out std_logic;
        db_jogada_correta   : out std_logic; -- novo nome: db_igual -> db_jogada_correta
        --db_enderecoIgualRodada    : out std_logic; -- nova saida
        --db_timeout                : out std_logic;
        db_contagem         : out std_logic_vector (6 downto 0);
        db_memoria          : out std_logic_vector (6 downto 0);
        db_jogadafeita      : out std_logic_vector (6 downto 0);
        --db_rodada               : out std_logic_vector (6 downto 0); -- nova saida
        db_estado           : out std_logic_vector (6 downto 0)
    );
  end component;
  
  ---- Declaracao de sinais de entrada para conectar o componente
  signal clk_in     : std_logic := '0';
  signal rst_in     : std_logic := '0';
  signal jogar_in   : std_logic := '0';
  signal botoes_in  : std_logic_vector(3 downto 0) := "0000";
  signal seletor_modo_in : std_logic_vector (1 downto 0) := "00";
  ----------------------------------------
  ---- Declaracao dos sinais de saida ----
  ----------------------------------------
  signal leds_out            : std_logic_vector(3 downto 0) := "0000";
  signal pronto_out          : std_logic := '0';
  signal pontuacao_out       : std_logic_vector(6 downto 0) := "0000000";
  signal clock_out           : std_logic := '0';
  signal tem_jogada_out      : std_logic := '0';
  signal jogada_correta_out  : std_logic := '0';
  signal contagem_out        : std_logic_vector(6 downto 0) := "0000000";
  signal memoria_out         : std_logic_vector(6 downto 0) := "0000000";
  signal jogada_out          : std_logic_vector(6 downto 0) := "0000000";
  signal estado_out          : std_logic_vector(6 downto 0) := "0000000";
  --------------------------------
  ---- Configurações do clock ----
  --------------------------------
  signal keep_simulating: std_logic := '0'; -- delimita o tempo de geração do clock
  constant clockPeriod : time := 20 ns;     -- frequencia 50MHz
  signal caso : integer := 0;
  
begin
  -- Gerador de clock: executa enquanto 'keep_simulating = 1', com o período especificado. 
  -- Quando keep_simulating=0, clock é interrompido, bem como a simulação de eventos
  clk_in <= (not clk_in) and keep_simulating after clockPeriod/2;
  
  ---- DUT para Simulacao
  dut: jogo_desafio_ritmo
       port map
       (
          clock          		  => clk_in,
          reset          		  => rst_in,
          jogar          		  => jogar_in,
          botoes         		  => botoes_in,
		  seletor_modo            => seletor_modo_in,
          leds           		  => leds_out,
		  pronto                  => pronto_out,
          pontuacao               => pontuacao_out,
          db_clock        		  => clock_out,
		  db_tem_jogada   		  => tem_jogada_out,
		  db_jogada_correta 	  => jogada_correta_out,
          db_contagem     	      => contagem_out,
          db_memoria      		  => memoria_out,
          db_jogadafeita  		  => jogada_out,  
		  db_estado       	 	  => estado_out                   
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

    -- espera para início dos testes
    caso <= 2;
    wait for 10 * clockPeriod;

    -- pulso do sinal de Iniciar (muda na borda de descida do clock)
    caso <= 3;
    seletor_modo_in <= "10"; -- Codigo do jogo normal
    wait for 100*clockPeriod;
 
	-- pulso do sinal de Iniciar (muda na borda de descida do clock)
    caso <= 4;
    wait until falling_edge(clk_in);
    jogar_in <= '1';
    wait for 1000*clockPeriod; -- 1 segundo: tempo para começar o jogo
    jogar_in <= '0';
    
    -- Cenario de Teste: sequencia basica de uma musica

    ----  jogada 1: acerta
    caso <= 5;
	wait for 100*clockPeriod;
    botoes_in <= "0001";
    wait for 100*clockPeriod;
    botoes_in <= "0001";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	---- jogada 2: acerta
    caso <= 6;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ---- jogada 3: acerta
    caso <= 7;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ---- jogada 4: acerta
    caso <= 8;
	wait for 100*clockPeriod;
    botoes_in <= "1000";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	---- jogada 5: acerta
    caso <= 9;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	---- jogada 6: acerta
    caso <= 10;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ---- jogada  7: acerta
    caso <= 11;
	wait for 100*clockPeriod;
    botoes_in <= "0001";
    wait for 100*clockPeriod;
    botoes_in <= "0001";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	----  jogada  8: acerta
    caso <= 12;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ----  jogada  9: acerta
    caso <= 13;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ----  jogada  10: acerta
    caso <= 14;
	wait for 100*clockPeriod;
    botoes_in <= "1000";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	----  jogada 11: acerta
    caso <= 15;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	----  jogada 12: acerta
    caso <= 16;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ----  jogada 13: acerta
    caso <= 17;
	wait for 100*clockPeriod;
    botoes_in <= "0001";
    wait for 100*clockPeriod;
    botoes_in <= "0001";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	----  jogada 14: acerta
    caso <= 18;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ----  jogada 15: acerta
    caso <= 19;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ---- jogada 16: acerta
    caso <= 20;
	wait for 100*clockPeriod;
    botoes_in <= "1000";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	----  jogada 17: acerta
    caso <= 21;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	---- jogada 18: acerta
    caso <= 22;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ---- jogada 19: acerta
    caso <= 23;
	wait for 100*clockPeriod;
    botoes_in <= "0001";
    wait for 100*clockPeriod;
    botoes_in <= "0001";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	---- jogada 20: acerta
    caso <= 24;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ---- jogada 21: acerta
    caso <= 25;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ---- jogada 22: acerta
    caso <= 26;
	wait for 100*clockPeriod;
    botoes_in <= "1000";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	----  jogada 23: acerta
    caso <= 27;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	----  jogada  24: acerta
    caso <= 28;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ----  jogada  25: acerta
    caso <= 29;
	wait for 100*clockPeriod;
    botoes_in <= "0001";
    wait for 100*clockPeriod;
    botoes_in <= "0001";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	----  jogada  26: acerta
    caso <= 30;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ----  jogada  27: acerta
    caso <= 31;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ----  jogada  28: acerta
    caso <= 32;
	wait for 100*clockPeriod;
    botoes_in <= "1000";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	---- jogada 29: acerta
    caso <= 33;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	---- jogada 30: acerta
    caso <= 34;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ----  jogada 31: acerta
    caso <= 35;
	wait for 100*clockPeriod;
    botoes_in <= "0001";
    wait for 100*clockPeriod;
    botoes_in <= "0001";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	---- jogada 32: acerta
    caso <= 36;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ---- jogada 33: acerta
    caso <= 37;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ---- jogada 34: acerta
    caso <= 38;
	wait for 100*clockPeriod;
    botoes_in <= "1000";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	---- jogada 35: acerta
    caso <= 39;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	---- jogada 36: acerta
    caso <= 40;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ---- jogada 37: acerta
    caso <= 41;
	wait for 100*clockPeriod;
    botoes_in <= "0001";
    wait for 100*clockPeriod;
    botoes_in <= "0001";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	---- jogada 38: acerta
    caso <= 42;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ---- jogada 39: acerta
    caso <= 43;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ---- jogada 40: acerta
    caso <= 44;
	wait for 100*clockPeriod;
    botoes_in <= "1000";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	---- jogada 41: acerta
    caso <= 45;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	---- jogada 42: acerta
    caso <= 46;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ----  jogada 43: acerta
    caso <= 47;
	wait for 100*clockPeriod;
    botoes_in <= "0001";
    wait for 100*clockPeriod;
    botoes_in <= "0001";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	----  jogada 44: acerta
    caso <= 48;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ----  jogada 45: acerta
    caso <= 49;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ----  jogada 46: acerta
    caso <= 50;
	wait for 100*clockPeriod;
    botoes_in <= "1000";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	----  jogada 47: acerta
    caso <= 51;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	----  jogada 48: acerta
    caso <= 52;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ----  jogada 49: acerta
    caso <= 53;
	wait for 100*clockPeriod;
    botoes_in <= "0001";
    wait for 100*clockPeriod;
    botoes_in <= "0001";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	----  jogada 50: acerta
    caso <= 54;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ----  jogada 51: acerta
    caso <= 55;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ----  jogada 52: acerta
    caso <= 56;
	wait for 100*clockPeriod;
    botoes_in <= "1000";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	----  jogada 53: acerta
    caso <= 57;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	----  jogada 54: acerta
    caso <= 58;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ----  jogada 55: acerta
    caso <= 59;
	wait for 100*clockPeriod;
    botoes_in <= "0001";
    wait for 100*clockPeriod;
    botoes_in <= "0001";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	---- jogada 56: acerta
    caso <= 60;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ---- jogada 57: acerta
    caso <= 61;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;

    ---- jogada 58: acerta
    caso <= 62;
	wait for 100*clockPeriod;
    botoes_in <= "1000";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	---- jogada 59: acerta
    caso <= 9;
	wait for 100*clockPeriod;
    botoes_in <= "0100";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
	----  jogada 60: acerta
    caso <= 63;
	wait for 100*clockPeriod;
    botoes_in <= "0010";
    wait for 100*clockPeriod;
    botoes_in <= "0000";
	
    ---- finaliza jogada 
    wait for 300*clockPeriod;
	
    ---- final do testbench
    assert false report "fim da simulacao" severity note;
    keep_simulating <= '0';
    
    wait; -- fim da simulação: processo aguarda indefinidamente
  end process;

end architecture;