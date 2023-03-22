-------------------------------------------------------------------
-- Arquivo   : ram_128x4.vhd
-- Projeto   : Projeto da disciplina
-------------------------------------------------------------------
-- Descricao : módulo de memória RAM sincrona 16x4 
--             sinais we e ce ativos em baixo
--             codigo ADAPTADO do código encontrado no livro 
--             VHDL Descricao e Sintese de Circuitos Digitais
--             de Roberto D'Amore, LTC Editora.
--             
-------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     08/01/2020  1.0     Edson Midorikawa  criacao
--     01/02/2020  2.0     Antonio V.S.Neto  Atualizacao para 
--                                           RAM sincrona para
--                                           minimizar problemas
--                                           com Quartus.
--     02/02/2020  2.1     Edson Midorikawa  revisao de codigo e
--                                           arquitetura para 
--                                           simulacao com ModelSim 
--     07/01/2023  2.1.1   Edson Midorikawa  revisao
--     11/03/2023  3.0     Rafael Innecco    Modificacao do tamanho da memória
--     20/03/2023  3.1     Rafael Innecco    Adição de saída com próximas posições
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity ram_Sx4 is
  generic (
    constant S  : integer := 128
  );
  port (       
       clk          : in  std_logic;
       endereco     : in  std_logic_vector(natural(ceil(log2(real(S)))) - 1 downto 0);
       dado_entrada : in  std_logic_vector(3 downto 0);
       we           : in  std_logic;
       ce           : in  std_logic;
       dado_saida   : out std_logic_vector(3 downto 0);
       next_data    : out std_logic_vector(15 downto 0)
    );
end entity ram_Sx4;

-- Dados iniciais em arquivo MIF (para sintese com Intel Quartus Prime) 
architecture ram_mif of ram_Sx4 is
  type   arranjo_memoria is array(0 to S) of std_logic_vector(3 downto 0);
  signal memoria : arranjo_memoria;
  
  -- Configuracao do Arquivo MIF
  attribute ram_init_file: string;
  attribute ram_init_file of memoria: signal is "ram_conteudo_jogadas.mif";
  
begin

  process(clk)
  begin
    if (clk = '1' and clk'event) then
          if ce = '0' then -- dado armazenado na subida de "we" com "ce=0"
           
              -- Detecta ativacao de we (ativo baixo)
              if (we = '0') 
                  then memoria(to_integer(unsigned(endereco))) <= dado_entrada;
              end if;
            
          end if;
      end if;
  end process;

  -- saida da memoria
  dado_saida <= memoria(to_integer(unsigned(endereco)));

  -- Indica valor das próximas 4 posições de memória
  next_data <= memoria(to_integer(unsigned(endereco))) & memoria(to_integer(unsigned(endereco) + 1)) & memoria(to_integer(unsigned(endereco) + 2)) & memoria(to_integer(unsigned(endereco) + 3));
  
end architecture ram_mif;

-- Dados iniciais (para simulacao com Modelsim) 
architecture ram_modelsim of ram_Sx4 is
  type   arranjo_memoria is array(0 to 71) of std_logic_vector(3 downto 0);
  signal memoria : arranjo_memoria := (
                                        "0000", "0000", "0000", "0000",
										                    "0001", "0010", "0100", "1000", "0100", "0010",
                                        "0001", "0010", "0100", "1000", "0100", "0010",
                                        "0001", "0010", "0100", "1000", "0100", "0010",
                                        "0001", "0010", "0100", "1000", "0100", "0010",
                                        "0001", "0010", "0100", "1000", "0100", "0010",
                                        "0001", "0010", "0100", "1000", "0100", "0010",
                                        "0001", "0010", "0100", "1000", "0100", "0010",
                                        "0001", "0010", "0100", "1000", "0100", "0010",
                                        "0001", "0010", "0100", "1000", "0100", "0010",
                                        "0001", "0010", "0100", "1000", "0100", "0010",
                                        "0001", "0010", "0100", "1000",
										                    "0000", "0000", "0000", "0000"
                                        );
  
begin

  process(clk)
  begin
    if (clk = '1' and clk'event) then
          if ce = '0' then -- dado armazenado na subida de "we" com "ce=0"
           
              -- Detecta ativacao de we (ativo baixo)
              if (we = '0') 
                  then memoria(to_integer(unsigned(endereco))) <= dado_entrada;
              end if;
            
          end if;
      end if;
  end process;

  -- saida da memoria
  dado_saida <= memoria(to_integer(unsigned(endereco)));

  next_data <= memoria(to_integer(unsigned(endereco))) & memoria(to_integer(unsigned(endereco) + 1)) & memoria(to_integer(unsigned(endereco) + 2)) & memoria(to_integer(unsigned(endereco) + 3));
end architecture ram_modelsim;