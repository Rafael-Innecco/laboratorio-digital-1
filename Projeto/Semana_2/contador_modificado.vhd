----------------Laboratorio Digital-------------------------------------
-- Arquivo   : contador_modificado.vhd
-- Projeto   : Projeto final da disciplina
-------------------------------------------------------------------------
-- Descricao : contador binario, modulo m, com parâmetros M, P1 e P2 generic,
--             sinais para clear assincrono (zera_as) e sincrono (zera_s)
--             e saidas de fim e um quinto da contagem
-- 
--             calculo do numero de bits do contador em funcao do modulo:
--             N = natural(ceil(log2(real(M))))
--
-- Exemplo de instanciacao: contador módulo 50
--             CONT50: contador_modificado
--                     generic map ( M=> 50 )
--                     port map ( ...
--             
-------------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     09/09/2019  1.0     Edson Midorikawa  criacao
--     08/06/2020  1.1     Edson Midorikawa  revisao e melhoria de codigo 
--     09/09/2020  1.2     Edson Midorikawa  revisao 
--     30/01/2022  2.0     Edson Midorikawa  revisao do componente
--     29/01/2023  2.1     Edson Midorikawa  revisao do componente
--     15/03/2023  3.0     Rafael Innecco    Modificação para uso no projeto
-------------------------------------------------------------------------
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity contador_modificado is
    generic (
        constant M  : integer := 100; -- modulo do contador
        constant P1 : integer := 50; -- primeiro ponto de interesse
        constant P2 : integer := 25 -- segundo ponto de interesse
    );
    port (
        clock    	: in  std_logic;
        zera_as  	: in  std_logic;
        zera_s   	: in  std_logic;
        conta    	: in  std_logic;
        Q        	: out std_logic_vector(natural(ceil(log2(real(M))))-1 downto 0);
        fim         : out std_logic;
        ponto_1     : out std_logic;
        ponto_2     : out std_logic
    );
end entity contador_modificado;

architecture comportamental of contador_modificado is
    signal IQ: integer range 0 to M-1;
begin
  
    process (clock,zera_as,zera_s,conta,IQ)
    begin
        if zera_as='1' then    IQ <= 0;   
        elsif rising_edge(clock) then
            if zera_s='1' then IQ <= 0;
            elsif conta='1' then 
                if IQ=M-1 then IQ <= 0; 
                else           IQ <= IQ + 1; 
                end if;
            else               IQ <= IQ;
            end if;
        end if;
    end process;

    -- saida fim
    fim <= '1' when IQ=M-1 else
           '0';

    -- saida ponto_1
    ponto_1 <= '1' when IQ=P1-1 else
            '0';
    -- saída ponto_2
    ponto_2 <= '1' when IQ=P2-1 else
            '0';
    -- saida Q
    Q <= std_logic_vector(to_unsigned(IQ, Q'length));

end architecture comportamental;