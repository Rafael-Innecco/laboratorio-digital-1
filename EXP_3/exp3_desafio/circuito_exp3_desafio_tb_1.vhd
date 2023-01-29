--------------------------------------------------------------------
-- Arquivo   : circuito_exp3_tb.vhd
-- Projeto   : Experiencia 3 - Projeto de uma Unidade de Controle
--------------------------------------------------------------------
-- Descricao : testbench para circuito da experiencia 3 
--
--             1) plano de teste: 16 casos de teste
--
-- 
--------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     20/01/2022  1.0     Edson Midorikawa  versao inicial
--     22/01/2023  1.1     Edson Midorikawa  revisao
--------------------------------------------------------------------
--
library ieee;
use ieee.std_logic_1164.all;

entity circuito_exp3_desafio_tb_1 is
end entity;

architecture tb of circuito_exp3_desafio_tb_1 is
  
  -- Componente a ser testado (Device Under Test -- DUT)
  component circuito_exp3_desafio is
    port (
        clock       : in  std_logic;
        reset       : in  std_logic;
        iniciar     : in  std_logic;
        chaves      : in  std_logic_vector (3 downto 0);
        pronto      : out std_logic;
        acertou     : out std_logic;
        errou       : out std_logic;
        db_igual    : out std_logic;
        db_iniciar  : out std_logic;
        db_contagem : out std_logic_vector (6 downto 0);
        db_memoria  : out std_logic_vector (6 downto 0);
        db_chaves   : out std_logic_vector (6 downto 0);
        db_estado   : out std_logic_vector (6 downto 0)
    );
  end component;
  
  -- Declaração de sinais para conectar o componente a ser testado (DUT)
  --   valores iniciais para fins de simulacao (GHDL ou ModelSim)
  signal clock_in         : std_logic := '0';
  signal reset_in         : std_logic := '0';
  signal iniciar_in       : std_logic := '0';
  signal chaves_in        : std_logic_vector (3 downto 0) := "0000";
  signal pronto_out       : std_logic := '0';
  signal acertou_out      : std_logic := '0';
  signal errou_out        : std_logic := '0';
  signal db_igual_out     : std_logic := '0';
  signal db_iniciar_out   : std_logic := '0';
  signal db_contagem_out  : std_logic_vector (6 downto 0) := "0000000";
  signal db_memoria_out   : std_logic_vector (6 downto 0) := "0000000";
  signal db_chaves_out    : std_logic_vector (6 downto 0) := "0000000";
  signal db_estado_out    : std_logic_vector (6 downto 0) := "0000000";

  -- Configurações do clock
  signal keep_simulating : std_logic := '0'; -- delimita o tempo de geração do clock
  constant clockPeriod   : time := 20 ns;
  
  -- Identificacao de casos de teste
  signal caso : integer := 0;

begin
  
  -- Gerador de clock: executa enquanto 'keep_simulating = 1', com o período especificado. 
  -- Quando keep_simulating=0, clock é interrompido, bem como a simulação de eventos
  clock_in <= (not clock_in) and keep_simulating after clockPeriod/2;

  -- Conecta DUT (Device Under Test)
  dut: circuito_exp3_desafio 
       port map( 
           clock         =>  clock_in,
           reset         =>  reset_in,
           iniciar       =>  iniciar_in,
           chaves        =>  chaves_in,
           pronto        =>  pronto_out,
           acertou       =>  acertou_out,
           errou         =>  errou_out,
           db_igual      =>  db_igual_out,
           db_iniciar    =>  db_iniciar_out,
           db_contagem   =>  db_contagem_out,
           db_memoria    =>  db_memoria_out,
           db_chaves     =>  db_chaves_out,
           db_estado     =>  db_estado_out  
       );

  -- geracao dos sinais de entrada (estimulos)
  stimulus: process is
  begin

    assert false report "Inicio da simulacao" severity note;
    keep_simulating <= '1';  -- inicia geracao do sinal de clock
    
    ---- condicoes iniciais ----------------
    caso       <= 0;
    reset_in   <= '0';
    iniciar_in <= '0';
    chaves_in  <= "0000";
    wait for clockPeriod;


    ---- Teste 1 
    caso       <= 1;
    -- gera pulso de reset
    wait until falling_edge(clock_in);
    reset_in   <= '1';
    wait for clockPeriod;
    reset_in   <= '0';


    ---- Teste 2
    caso <= 2;
    -- espera por 5 periodos de clock
    wait for 2*clockPeriod;


    ---- Teste 3
    caso <= 3;
    chaves_in  <= "0001";    
    -- pulso em iniciar
    wait until falling_edge(clock_in);
    iniciar_in <= '1';
    wait for 3*clockPeriod;
    iniciar_in <= '0';


    ---- Teste 4
    caso <= 4;
    chaves_in  <= "0010";
    wait for 3*clockPeriod;


    ---- Teste 5
    caso <= 5;
    chaves_in  <= "0100";
    wait for 3*clockPeriod;



    ---- Teste 6
    caso <= 6;
    chaves_in  <= "1000";
    wait for 3*clockPeriod;


    ---- Teste 7
    caso <= 7;
    chaves_in  <= "0100";
    wait for 3*clockPeriod;


    ---- Teste 8
    caso <= 8;
    chaves_in  <= "0010";
    wait for 3*clockPeriod;


    ---- Teste 9
    caso <= 9;
    chaves_in  <= "0001";
    wait for 3*clockPeriod;


    ---- Teste 10
    caso <= 10;
    chaves_in  <= "0001";
    wait for 3*clockPeriod;


    ---- Teste 11
    caso <= 11;
    chaves_in  <= "0010";
    wait for 3*clockPeriod;


    ---- Teste 12
    caso <= 12;
    chaves_in  <= "0010";
    wait for 3*clockPeriod;


    ---- Teste 13   
    caso <= 13;
    chaves_in  <= "0100";
    wait for 3*clockPeriod;


    ---- Teste 14   
    caso <= 14;
    chaves_in  <= "0100";
    wait for 3*clockPeriod;


    ---- Teste 15
    caso <= 15;
    chaves_in  <= "1000";
    wait for 3*clockPeriod;


    ---- Teste 16 
    caso <= 16;
    chaves_in  <= "1000";
    wait for 3*clockPeriod;


    ---- Teste 17
    caso <= 17;
    chaves_in <= "0001";
    wait for 3*clockPeriod;


    ---- Teste 18
    caso <= 18;
    chaves_in <= "0100";
    wait for 3*clockPeriod;


    --Teste 19
    caso <= 19;
    chaves_in <= "0100";
    wait for clockPeriod;


    --Teste 20
    caso <= 20;
    chaves_in <= "0100";
    wait for clockPeriod;

    ---- final dos casos de teste  da simulacao
    assert false report "Fim da simulacao" severity note;
    keep_simulating <= '0';
    
    wait; -- fim da simulação: aguarda indefinidamente
  end process;

end architecture;
