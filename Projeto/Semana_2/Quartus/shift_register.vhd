-----------------Laboratorio Digital-------------------------------------
-- Arquivo   : shift_register.vhd
-- Projeto   : Projeto da disciplina
-------------------------------------------------------------------------
-- Descricao : registrador com shift com numero de bits N como generic
--             com clear assincrono e carga sincrona. Enable separado para carga
--             e shift lógico para a esquerda
--
--             baseado no código registrador_n disponibilizado pelos professores da disciplina
--             baseado no codigo vreg16.vhd do livro
--             J. Wakerly, Digital design: principles and practices 4e
--
-- Exemplo de instanciacao:
--      REG1 : registrador_n
--             generic map ( N => 12 )
--             port map (
--                 clock  => clock, 
--                 clear  => zera_reg1, 
--                 enable_l => registra1,
--                 enable_s => faz_shift
--                 D      => s_medida, 
--                 Q      => distancia
--             );
-------------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     15/03/2023  1.0     Rafael Innecco    Versão inicial
-------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shift_register is
    generic (
        constant N              : integer := 8;
        constant reset_value    : integer := 0
    );
    port (
        clock       : in std_logic;
        clear       : in std_logic;
        enable_l    : in std_logic;
        enable_s    : in std_logic;
        D           : in  std_logic_vector (N-1 downto 0);
        Q           : out std_logic_vector (N-1 downto 0) 
    );
end entity shift_register;

architecture comportamental of shift_register is
    signal IQ: std_logic_vector(N-1 downto 0);
begin

    process(clock, clear, enable_l, enable_s, IQ)
    begin
        if (clear = '1') then IQ <= std_logic_vector(to_unsigned(reset_value, N));
        elsif (clock'event and clock='1') then
            if (enable_l ='1') then IQ <= D;
            elsif (enable_s = '1') then IQ <= "0" & IQ(N-1 downto 1); 
            else IQ <= IQ;
            end if;
        end if;
        Q <= IQ;
    end process;
  
end architecture comportamental;