-------------------------------------------------------
--! @file somador.vhdl
--! @brief Unidade combinatória para soma
--! @author Rafael de A. Innecco
--! @date 2021-11-10
-------------------------------------------------------
--------------------------------------------------------------------
-- Arquivo   : somador.txt
-- Projeto   : Projeto PCS3635 2023
--------------------------------------------------------------------
-- Descricao :
--    Unidade combinatória para soma
--------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     10/11/2021  1.0     Rafael Innecco    veesão utilziada em uma ULA
--     17/03/2023  2.0     Rafael Innecco    Versão para uso no projeto, troca de fomrado bit para std_logic
--------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity somador is
    generic (
        size : natural := 8
    );

    port (
        A, B : in std_logic_vector (size - 1 downto 0); --inputs
        F : out std_logic_vector (size - 1 downto 0);
        Z : out std_logic; --zero flag
        Ov : out std_logic; --overflow flag
        Co : out std_logic --carry out flag
    );
end entity somador;

architecture dataflow of somador is

    signal SAI  : std_logic_vector (size - 1 downto 0); --Sinais intermediários
    signal CA   : std_logic_vector (size downto 0); -- Sinais utilizados para realizar o carry na soma e na subtração

begin
    -- Implementação da soma por Carry-lookahead
    CA(0) <= '0'; --Carry-in = 0
    GEN_2: for j in 1 to (size) generate
        CA(j) <= (A(j - 1) and B(j - 1)) or ((A(j - 1) or B(j - 1)) and CA(j - 1)); --Carry da soma do j-ésimo std_logic
    end generate GEN_2;

    GEN_3: for j in 0 to (size - 1) generate
        SAI(j) <= A(j) xor B(j) xor CA(j);
    end generate GEN_3;

    -- Implementação de flags

    -- Flag de overflow
    Ov <= CA(size) xor CA(size - 1);
    --

    -- Flag  de Carry-out
    Co <= CA(size);
    --

    Z <= '1' when SAI = std_logic_vector(to_unsigned(0, size)) else
         '0';
    --

    F <= SAI;

end architecture dataflow;