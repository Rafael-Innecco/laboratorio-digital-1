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
entity circuito_exp4_tb_acerto is
end entity;

architecture tb of circuito_exp4_tb_acerto is

  -- Componente a ser testado (Device Under Test -- DUT)
  component circuito_exp4
    port (
        clock          : in  std_logic;
        reset          : in  std_logic;
        iniciar        : in  std_logic;
        chaves         : in  std_logic_vector (3 downto 0);
        pronto         : out std_logic;
        acertou        : out std_logic;
        errou          : out std_logic;
        leds           : out std_logic_vector (3 downto 0);
        db_igual       : out std_logic;
        db_contagem    : out std_logic_vector (6 downto 0);
        db_memoria     : out std_logic_vector (6 downto 0);
        db_estado      : out std_logic_vector (6 downto 0);
        db_jogadafeita : out std_logic_vector (6 downto 0);
        db_clock       : out std_logic;
        db_tem_jogada  : out std_logic
    );
  end component;
  
  ---- Declaracao de sinais de entrada para conectar o componente
  signal clk_in     : std_logic := '0';
  signal rst_in     : std_logic := '0';
  signal iniciar_in : std_logic := '0';
  signal chaves_in  : std_logic_vector(3 downto 0) := "0000";

  ---- Declaracao dos sinais de saida
  signal igual_out      : std_logic := '0';
  signal acertou_out    : std_logic := '0';
  signal errou_out      : std_logic := '0';
  signal pronto_out     : std_logic := '0';
  signal leds_out       : std_logic_vector(3 downto 0) := "0000";
  signal clock_out      : std_logic := '0';
  signal tem_jogada_out : std_logic := '0';
  signal contagem_out   : std_logic_vector(6 downto 0) := "0000000";
  signal memoria_out    : std_logic_vector(6 downto 0) := "0000000";
  signal estado_out     : std_logic_vector(6 downto 0) := "0000000";
  signal jogada_out     : std_logic_vector(6 downto 0) := "0000000";

  -- Configurações do clock
  signal keep_simulating: std_logic := '0'; -- delimita o tempo de geração do clock
  constant clockPeriod : time := 20 ns;     -- frequencia 50MHz
  signal caso  : integer := 0;
  
begin
  -- Gerador de clock: executa enquanto 'keep_simulating = 1', com o período especificado. 
  -- Quando keep_simulating=0, clock é interrompido, bem como a simulação de eventos
  clk_in <= (not clk_in) and keep_simulating after clockPeriod/2;
  
  ---- DUT para Simulacao
  dut: circuito_exp4
       port map
       (
          clock           => clk_in,
          reset           => rst_in,
          iniciar         => iniciar_in,
          chaves          => chaves_in,
          acertou         => acertou_out,
          errou           => errou_out,
          pronto          => pronto_out,
          leds            => leds_out,
          db_igual        => igual_out,
          db_contagem     => contagem_out,
          db_memoria      => memoria_out,
          db_estado       => estado_out,
          db_jogadafeita  => jogada_out,  
          db_clock        => clock_out,
          db_tem_jogada   => tem_jogada_out
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
    iniciar_in <= '1';
    wait until falling_edge(clk_in);
    iniciar_in <= '0';
    
    -- espera para inicio dos testes
    caso <= 3;
    wait for 10*clockPeriod;
    wait until falling_edge(clk_in);

    -- Cenario de Teste - acerta as 4 primeiras jogadas e erra a 5a jogada

    ---- jogada #1 (chaves=0001 e 15 clocks de duracao)
    caso <= 4;
    chaves_in <= "0001";
    wait for 15*clockPeriod;
    chaves_in <= "0000";
    -- espera entre jogadas de 10 clocks
    wait for 10*clockPeriod;  

    ---- jogada #2 (chaves=0010 e 5 clocks de duracao)
    caso <= 5;
    chaves_in <= "0010";
    wait for 5*clockPeriod;
    chaves_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
 
    ---- jogada #3 (chaves=0100 e 7 clocks de duracao)
    caso <= 6;
    chaves_in <= "0100";
    wait for 7*clockPeriod;
    chaves_in <= "0000";
    -- espera entre jogadas
    wait for 10*clockPeriod;  

    ---- jogada #4 (chaves=1000 e 15 clocks de duracao)
    caso <= 7;
    chaves_in <= "1000";
    wait for 15*clockPeriod;
    chaves_in <= "0000";
    ---- espera entre jogadas
    wait for 10*clockPeriod;
 
    ---- jogada #5 (chaves=0100 e 12 clocks de duracao)
    caso <= 8;
    chaves_in <= "0100";
    wait for 12*clockPeriod;
    chaves_in <= "0000";
    -- espera entre jogadas
    wait for 20*clockPeriod;
    
    -- jogada #6 (chaves=0010)
    caso <= 9;
    chaves_in <= "0010";
    wait for 5*clockPeriod;
    chaves_in <= "0000";
    wait for 7*clockPeriod;

    -- jogada #7 (chaves=0001)
    caso <= 10;
    chaves_in <= "0001";
    wait for 5*clockPeriod;
    chaves_in <= "0000";
    wait for 7*clockPeriod;

    -- jogada #8 (chaves=0001)
    caso <= 11;
    chaves_in <= "0001";
    wait for 5*clockPeriod;
    chaves_in <= "0000";
    wait for 7*clockPeriod;

    -- jogada #9 (chaves=0010)
    caso <= 12;
    chaves_in <= "0010";
    wait for 5*clockPeriod;
    chaves_in <= "0000";
    wait for 7*clockPeriod;

    -- jogada #10 (chaves=0010)
    caso <= 13;
    chaves_in <= "0010"; 
    wait for 5*clockPeriod;
    chaves_in <= "0000";
    wait for 7*clockPeriod;

    -- jogada #11 (chaves=0100)
    caso <= 14;
    chaves_in <= "0100"; 
    wait for 5*clockPeriod;
    chaves_in <= "0000";
    wait for 7*clockPeriod;

    -- jogada #12 (chaves=0100)
    caso <= 15;
    chaves_in <= "0100";
    wait for 5*clockPeriod;
    chaves_in <= "0000";
    wait for 7*clockPeriod;

    -- jogada #13 (chaves=1000)
    caso <= 16;
    chaves_in <= "1000";
    wait for 5*clockPeriod;
    chaves_in <= "0000";
    wait for 7*clockPeriod;

    -- jogada #14 (chaves=1000)
    caso <= 17;
    chaves_in <= "1000";
    wait for 5*clockPeriod;
    chaves_in <= "0000";
    wait for 7*clockPeriod;

    -- jogada #15 (chaves=0001)
    caso <= 18;
    chaves_in <= "0001";
    wait for 5*clockPeriod;
    chaves_in <= "0000";
    wait for 7*clockPeriod;

    -- jogada final (chaves=0100)
    caso <= 19;
    chaves_in <= "0100";
    wait for 5*clockPeriod;
    chaves_in <= "0000";
    wait for 7*clockPeriod;

    ---- final do testbench
    assert false report "fim da simulacao" severity note;
    keep_simulating <= '0';
    
    wait; -- fim da simulação: processo aguarda indefinidamente
  end process;


end architecture;
