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
--------------------------------------------------------------------
--

library ieee;
use ieee.std_logic_1164.all;

entity unidade_controle is
    port (
        clock       : in std_logic;
        reset       : in std_logic;
        iniciar     : in std_logic;
        fim         : in std_logic;
        jogada      : in std_logic;
        igual       : in std_logic;
        zeraC       : out std_logic;
        contaC      : out std_logic;
        zeraR       : out std_logic;
        registraR   : out std_logic;
        acertou     : out std_logic := 0;
        errou       : out std_logic := 0;
        pronto      : out std_logic;
        db_estado   : out std_logic_vector(3 downto 0)
    );
end entity;

architecture fsm of unidade_controle is
    type t_estado is (inicial, inicializa_elem, espera, registra, compara, proximo, fim_erro, fim_certo);
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

    -- logica de proximo estado
    Eprox <=
        inicial         when  Eatual=inicial and iniciar='0' else
        inicializa_elem when  (Eatual=inicial or Eatual=fim_certo or Eatual=fim_erro) and iniciar='1' else
        espera          when  (Eatual=inicializa_elem) or (Eatual=proximo) or (Eatual = espera and jogada='0') else
        registra        when  (Eatual=espera and jogada='1') else
        compara         when  Eatual=registra else
        proximo         when  Eatual=compara and fim='0' and igual = '1' else
        fim_erro        when  (Eatual=compara and igual = '0') or (Eatual=fim_erro and iniciar='0') else
        fim_certo       when  (Eatual=compara and fim='1' and igual = '1')  or  (Eatual=fim_certo and iniciar = '0') else
        inicial;

    -- logica de saída (maquina de Moore)
    with Eatual select
        zeraC <=        '1' when inicial | inicializa_elem,
                        '0' when others;
    
    with Eatual select
        zeraR <=        '1' when inicial | inicializa_elem,
                        '0' when others;
    
    with Eatual select
        registraR <=    '1' when registra,
                        '0' when others;

    with Eatual select
        contaC <=       '1' when proximo,
                        '0' when others;
    
    with Eatual select
        pronto <=       '1' when fim_certo | fim_erro,
                        '0' when others;
    
    with Eatual select
        acertou <=      '1' when fim_certo,
                        '0' when others;
    
    with Eatual select
        errou <=        '1' when fim_erro,
                        '0' when others;
    
    -- saida de depuracao (db_estado)
    with Eatual select
        db_estado <= "0000" when inicial,           -- 0
                     "0001" when inicializa_elem,   -- 1
                     "0010" when espera,            -- 2
                     "0100" when registra,          -- 4
                     "0101" when compara,           -- 5
                     "0110" when proximo,           -- 6
                     "1001" when fim_erro,          -- 9
                     "1100" when fim_certo,         -- C
                     "1111" when others;            -- F

end architecture fsm;
