--------------------------------------------------------------------------
-- Arquivo   : edge_holder.vhd
-- Projeto   : Projeto final de PCS3635
--------------------------------------------------------------------------
-- Descricao : indica quais bits da entrada tiveram borda de subida
--             desde o último reset
--------------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     29/01/2020  1.0     Rafael Innecco   criacao
--------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity edge_holder is
    generic (
        constant size : natural := 8
    );
    port (
        clock   : in std_logic;
        reset   : in std_logic;
        entrada : in std_logic_vector(size-1 downto 0);
        saida   : out std_logic_vector(size-1 downto 0)
    );
end entity edge_holder;

architecture estrutural of edge_holder is
    component edge_detector is
        port (
            clock   : in std_logic;
            reset   : in std_logic;
            sinal   : in std_logic;
            pulso   : out std_logic
        );
    end component;
    signal pulsos   : std_logic_vector (size-1 downto 0);
    signal saida_int: std_logic_vector (size-1 downto 0);
begin
    ED: for j in 0 to (size - 1) generate
        detect_j: edge_detector port map (
            clock   => clock,
            reset   => reset,
            sinal   => entrada(j),
            pulso   => pulsos(j)
        );
    end generate ED;

    GENS: for j in 0 to (size-1) generate
        saida_int(j) <= (pulsos(j) or saida_int(j)) and (not reset);
    end generate GENS;

    saida <= saida_int;
end architecture estrutural;