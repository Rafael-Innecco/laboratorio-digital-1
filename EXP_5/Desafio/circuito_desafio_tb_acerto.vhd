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

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;

-- entidade do testbench
entity circuito_desafio_exp5_tb_acerto is
end entity;

architecture tb of circuito_desafio_exp5_tb_acerto is

  -- Componente a ser testado (Device Under Test -- DUT)
  component circuito_desafio_exp5
    port (
        clock           	      : in std_logic;
        reset           		    : in std_logic;
        jogar       		        : in std_logic; -- novo nome: iniciar -> jogar
        botoes        		      : in std_logic_vector (3 downto 0); -- novo nome: chaves -> botoes
        leds           			    : out std_logic_vector (3 downto 0);
		    pronto          		    : out std_logic;
        ganhou          		    : out std_logic; -- novo nome: acertou -> ganhou
        perdeu           		    : out std_logic;     
        db_clock                : out std_logic;
        db_tem_jogada    		    : out std_logic;
        db_jogada_correta       : out std_logic; -- novo nome: db_igual -> db_jogada_correta
        db_enderecoIgualRodada  : out std_logic; -- nova saida
        db_timeout				      : out std_logic;
        db_contagem     		    : out std_logic_vector (6 downto 0);
        db_memoria      		    : out std_logic_vector (6 downto 0);
        db_jogadafeita 			    : out std_logic_vector (6 downto 0);
        db_rodada       		    : out std_logic_vector (6 downto 0); -- nova saida
        db_estado       		    : out std_logic_vector (6 downto 0)      
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
  dut: circuito_desafio_exp5
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


    -- pulso do sinal de Iniciar (muda na borda de descida do clock)
    caso <= 2;
    wait until falling_edge(clk_in);
    jogar_in <= '1';
    wait until falling_edge(clk_in);
    jogar_in <= '0';
    
    -- espera para inicio dos testes
    caso <= 3;
    wait for 10*clockPeriod;
    wait until falling_edge(clk_in);

    -- Cenario de Teste - acerta todas as jogadas

    ---- jogada #1 rodada #2 (chaves=0001 e 5 clocks de duracao)
    caso <= 5;
    botoes_in <= "0001";
    wait for 5*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
 
    ---- jogada #2 rodada #2 (chaves=0010 e 7 clocks de duracao)
    caso <= 6;
    botoes_in <= "0010";
    wait for 7*clockPeriod;
    botoes_in <= "0000";
    -- espera entre jogadas
    wait for 10*clockPeriod;  

    ---- jogada #1 rodada #3 (chaves=0001 e 15 clocks de duracao)
    caso <= 7;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
 
	---- jogada #2 rodada #3 (chaves=0010 e 15 clocks de duracao)
    caso <= 8;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
 
	---- jogada #3 rodada #3 (chaves=0100 e 15 clocks de duracao)
    caso <= 9;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
	
	---- jogada #1 rodada #4 (chaves=0001 e 15 clocks de duracao)
    caso <= 10;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
	
	---- jogada #2 rodada #4 (chaves=0010 e 15 clocks de duracao)
    caso <= 11;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
	
	---- jogada #3 rodada #4 (chaves=1000 e 15 clocks de duracao)
    caso <= 12;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
    
  --- jogada #4 rodada #4 (chaves = 0100 e 15 clocks de duração)
    caso <= 13;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    ---- jogada #1 rodada #5 (chaves=0001 e 15 clocks de duracao)
    caso <= 14;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #2 rodada #5 (chaves=0010 e 15 clocks de duracao)
    caso <= 15;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #3 rodada #5 (chaves=1000 e 15 clocks de duracao)
    caso <= 16;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #4 rodada #5 (chaves = 0100 e 15 clocks de duração)
    caso <= 17;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #5 rodada #5 (chaves = 0100 e 15 clocks de duração)
    caso <= 18;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;


    ---- jogada #1 rodada #6 (chaves=0001 e 15 clocks de duracao)
    caso <= 19;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #2 rodada #6 (chaves=0010 e 15 clocks de duracao)
    caso <= 20;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #3 rodada #6 (chaves=1000 e 15 clocks de duracao)
    caso <= 21;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #4 rodada #6 (chaves = 1000 e 15 clocks de duração)
    caso <= 22;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #5 rodada #6 (15 clocks de duração)
    caso <= 23;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #6 rodada #6 (15 clocks de duração)
    caso <= 24;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    ---- jogada #1 rodada #7 (chaves=0001 e 15 clocks de duracao)
    caso <= 25;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #2 rodada #7 (chaves=0010 e 15 clocks de duracao)
    caso <= 26;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #3 rodada #7 (chaves=1000 e 15 clocks de duracao)
    caso <= 27;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #4 rodada #7 (chaves = 1000 e 15 clocks de duração)
    caso <= 28;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #5 rodada #7 (15 clocks de duração)
    caso <= 29;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #6 rodada #7 (15 clocks de duração)
    caso <= 30;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #7 rodada #7 (15 clocks de duração)
    caso <= 31;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    ---- jogada #1 rodada #8 (chaves=0001 e 15 clocks de duracao)
    caso <= 32;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #2 rodada #8 (chaves=0010 e 15 clocks de duracao)
    caso <= 33;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #3 rodada #8 (chaves=1000 e 15 clocks de duracao)
    caso <= 34;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #4 rodada #8 (chaves = 1000 e 15 clocks de duração)
    caso <= 35;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #5 rodada #8 (15 clocks de duração)
    caso <= 36;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #6 rodada #8 (15 clocks de duração)
    caso <= 37;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #7 rodada #8 (15 clocks de duração)
    caso <= 38;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #8 rodada #8 (15 clocks de duração)
    caso <= 39;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    ---- jogada #1 rodada #9 (chaves=0001 e 15 clocks de duracao)
    caso <= 40;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #2 rodada #9 (chaves=0010 e 15 clocks de duracao)
    caso <= 41;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #3 rodada #9 (chaves=1000 e 15 clocks de duracao)
    caso <= 42;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #4 rodada #9 (chaves = 1000 e 15 clocks de duração)
    caso <= 43;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #5 rodada #9 (15 clocks de duração)
    caso <= 44;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #6 rodada #9 (15 clocks de duração)
    caso <= 45;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #7 rodada #9 (15 clocks de duração)
    caso <= 46;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #8 rodada #9 (15 clocks de duração)
    caso <= 47;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #9 rodada #9 (15 clocks de duração)
    caso <= 48;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    ---- jogada #1 rodada #10 (chaves=0001 e 15 clocks de duracao)
    caso <= 49;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #2 rodada #10 (chaves=0010 e 15 clocks de duracao)
    caso <= 50;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #3 rodada #10 (chaves=1000 e 15 clocks de duracao)
    caso <= 51;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #4 rodada #10 (chaves = 1000 e 15 clocks de duração)
    caso <= 52;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #5 rodada #10 (15 clocks de duração)
    caso <= 53;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #6 rodada #10 (15 clocks de duração)
    caso <= 54;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #7 rodada #10 (15 clocks de duração)
    caso <= 55;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #8 rodada #10 (15 clocks de duração)
    caso <= 56;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #9 rodada #10 (15 clocks de duração)
    caso <= 57;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #10 rodada #10 (15 clocks de duração)
    caso <= 58;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    ---- jogada #1 rodada #11 (chaves=0001 e 15 clocks de duracao)
    caso <= 59;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #2 rodada #11 (chaves=0010 e 15 clocks de duracao)
    caso <= 60;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #3 rodada #11 (chaves=1000 e 15 clocks de duracao)
    caso <= 61;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #4 rodada #11 (chaves = 1000 e 15 clocks de duração)
    caso <= 62;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #5 rodada #11 (15 clocks de duração)
    caso <= 63;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #6 rodada #11 (15 clocks de duração)
    caso <= 64;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #7 rodada #11 (15 clocks de duração)
    caso <= 65;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #8 rodada #11 (15 clocks de duração)
    caso <= 66;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #9 rodada #11 (15 clocks de duração)
    caso <= 67;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #10 rodada #11 (15 clocks de duração)
    caso <= 68;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #11 rodada #11 (15 clocks de duração)
    caso <= 69;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    ---- jogada #1 rodada #12 (chaves=0001 e 15 clocks de duracao)
    caso <= 70;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #2 rodada #12 (chaves=0010 e 15 clocks de duracao)
    caso <= 71;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #3 rodada #12 (chaves=1000 e 15 clocks de duracao)
    caso <= 72;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #4 rodada #12 (chaves = 1000 e 15 clocks de duração)
    caso <= 73;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #5 rodada #12 (15 clocks de duração)
    caso <= 74;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #6 rodada #12 (15 clocks de duração)
    caso <= 75;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #7 rodada #12 (15 clocks de duração)
    caso <= 76;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #8 rodada #12 (15 clocks de duração)
    caso <= 77;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #9 rodada #12 (15 clocks de duração)
    caso <= 78;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #10 rodada #12 (15 clocks de duração)
    caso <= 79;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #11 rodada #12 (15 clocks de duração)
    caso <= 80;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #12 rodada #12 (15 clocks de duração)
    caso <= 81;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    ---- jogada #1 rodada #13 (chaves=0001 e 15 clocks de duracao)
    caso <= 82;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #2 rodada #13 (chaves=0010 e 15 clocks de duracao)
    caso <= 83;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #3 rodada #13 (chaves=1000 e 15 clocks de duracao)
    caso <= 84;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #4 rodada #13 (chaves = 1000 e 15 clocks de duração)
    caso <= 85;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #5 rodada #13 (15 clocks de duração)
    caso <= 86;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #6 rodada #13 (15 clocks de duração)
    caso <= 87;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #7 rodada #13 (15 clocks de duração)
    caso <= 88;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #8 rodada #13 (15 clocks de duração)
    caso <= 89;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #9 rodada #13 (15 clocks de duração)
    caso <= 90;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #10 rodada #13 (15 clocks de duração)
    caso <= 91;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #11 rodada #13 (15 clocks de duração)
    caso <= 92;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #12 rodada #13 (15 clocks de duração)
    caso <= 93;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #13 rodada #13 (15 clocks de duração)
    caso <= 94;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    ---- jogada #1 rodada #14 (chaves=0001 e 15 clocks de duracao)
    caso <= 95;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #2 rodada #14 (chaves=0010 e 15 clocks de duracao)
    caso <= 96;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #3 rodada #14 (chaves=1000 e 15 clocks de duracao)
    caso <= 97;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #4 rodada #14 (chaves = 1000 e 15 clocks de duração)
    caso <= 98;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #5 rodada #14 (15 clocks de duração)
    caso <= 99;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #6 rodada #14 (15 clocks de duração)
    caso <= 100;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #7 rodada #14 (15 clocks de duração)
    caso <= 101;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #8 rodada #14 (15 clocks de duração)
    caso <= 102;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #9 rodada #14 (15 clocks de duração)
    caso <= 103;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #10 rodada #14 (15 clocks de duração)
    caso <= 104;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #11 rodada #14 (15 clocks de duração)
    caso <= 105;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #12 rodada #14 (15 clocks de duração)
    caso <= 106;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #13 rodada #14 (15 clocks de duração)
    caso <= 107;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #14 rodada #14 (15 clocks de duração)
    caso <= 108;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
  

    ---- jogada #1 rodada #15 (chaves=0001 e 15 clocks de duracao)
    caso <= 109;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #2 rodada #15 (chaves=0010 e 15 clocks de duracao)
    caso <= 110;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #3 rodada #15 (chaves=1000 e 15 clocks de duracao)
    caso <= 111;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #4 rodada #15 (chaves = 1000 e 15 clocks de duração)
    caso <= 112;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #5 rodada #15 (15 clocks de duração)
    caso <= 113;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #6 rodada #15 (15 clocks de duração)
    caso <= 114;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #7 rodada #15 (15 clocks de duração)
    caso <= 115;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #8 rodada #15 (15 clocks de duração)
    caso <= 116;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #9 rodada #15 (15 clocks de duração)
    caso <= 117;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #10 rodada #15 (15 clocks de duração)
    caso <= 118;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #11 rodada #15 (15 clocks de duração)
    caso <= 119;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #12 rodada #15 (15 clocks de duração)
    caso <= 120;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #13 rodada #15 (15 clocks de duração)
    caso <= 121;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #14 rodada #15 (15 clocks de duração)
    caso <= 122;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #15 rodada #15 (15 clocks de duração)
    caso <= 123;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    ---- jogada #1 rodada #16 (chaves=0001 e 15 clocks de duracao)
    caso <= 124;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #2 rodada #16 (chaves=0010 e 15 clocks de duracao)
    caso <= 125;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #3 rodada #16 (chaves=1000 e 15 clocks de duracao)
    caso <= 126;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #4 rodada #16 (chaves = 1000 e 15 clocks de duração)
    caso <= 127;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #5 rodada #16 (15 clocks de duração)
    caso <= 128;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #6 rodada #16 (15 clocks de duração)
    caso <= 129;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #7 rodada #16 (15 clocks de duração)
    caso <= 130;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #8 rodada #16 (15 clocks de duração)
    caso <= 131;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #9 rodada #16 (15 clocks de duração)
    caso <= 132;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #10 rodada #16 (15 clocks de duração)
    caso <= 133;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #11 rodada #16 (15 clocks de duração)
    caso <= 134;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #12 rodada #16 (15 clocks de duração)
    caso <= 135;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #13 rodada #16 (15 clocks de duração)
    caso <= 136;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #14 rodada #16 (15 clocks de duração)
    caso <= 137;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #15 rodada #16 (15 clocks de duração)
    caso <= 138;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #16 rodada #16 (15 clocks de duração)
    caso <= 139;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
	
	-- REAL RODADA 16 --
	    ---- jogada #1 rodada #16 (chaves=0001 e 15 clocks de duracao)
    caso <= 124;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #2 rodada #16 (chaves=0010 e 15 clocks de duracao)
    caso <= 125;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

  ---- jogada #3 rodada #16 (chaves=1000 e 15 clocks de duracao)
    caso <= 126;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #4 rodada #16 (chaves = 1000 e 15 clocks de duração)
    caso <= 127;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #5 rodada #16 (15 clocks de duração)
    caso <= 128;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #6 rodada #16 (15 clocks de duração)
    caso <= 129;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #7 rodada #16 (15 clocks de duração)
    caso <= 130;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #8 rodada #16 (15 clocks de duração)
    caso <= 131;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #9 rodada #16 (15 clocks de duração)
    caso <= 132;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #10 rodada #16 (15 clocks de duração)
    caso <= 133;
    botoes_in <= "0010";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #11 rodada #16 (15 clocks de duração)
    caso <= 134;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #12 rodada #16 (15 clocks de duração)
    caso <= 135;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #13 rodada #16 (15 clocks de duração)
    caso <= 136;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #14 rodada #16 (15 clocks de duração)
    caso <= 137;
    botoes_in <= "1000";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #15 rodada #16 (15 clocks de duração)
    caso <= 138;
    botoes_in <= "0001";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;

    --- jogada #16 rodada #16 (15 clocks de duração)
    caso <= 139;
    botoes_in <= "0100";
    wait for 15*clockPeriod;
    botoes_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
	
    ---- final do testbench
    assert false report "fim da simulacao" severity note;
    keep_simulating <= '0';
    
    wait; -- fim da simulação: processo aguarda indefinidamente
  end process;

end architecture;