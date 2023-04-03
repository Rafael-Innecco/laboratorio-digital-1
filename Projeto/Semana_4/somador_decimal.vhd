--------------------------------------------------------------------
-- Arquivo   : somador.vhd
-- Projeto   : Projeto PCS3635 2023
--------------------------------------------------------------------
-- Descricao :
--    Unidade combinatória para soma em decimal
--------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     26/03/2023  1.0     Rafael Innecco    cersão para projeto da disciplina
--------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity somador_decimal is
    generic (
        digits  : natural := 3
    );
    port (
        A   : in std_logic_vector (4*digits - 1 downto 0);
        B   : in std_logic_vector (3 downto 0);
        F   : out std_logic_vector (4*digits -1 downto 0)
    );
end entity somador_decimal;

architecture estrutural of somador_decimal is
    component somador is
        generic (
            size: natural := 8
        );
        port (
            A, B    : in std_logic_vector (size - 1 downto 0);
            S       : in std_logic;
            F       : out std_logic_vector (size-1 downto 0);
            Z       : out std_logic;
            N       : out std_logic;
            Ov      : out std_logic;
            Co      : out std_logic
        );
    end component;

    component hexDecimal is
        port (
            hexa    : in std_logic_vector (3 downto 0);
            Cin     : in std_logic;
            dec     : out std_logic_vector (3 downto 0);
            Cout    : out std_logic
        );
    end component;

    signal carry    : std_logic_vector (digits downto 0);
    signal f_int    : std_logic_vector (4*(digits)-1 downto 0);
begin
    carry(0) <= '0';

    soma_inicial: somador
    generic map (size => 4)
    port map (
        A => A(3 downto 0),
        B => B,
        S => '0',
        F => f_int(3 downto 0),
        Z => open,
        N => open,
        Ov => open,
        Co => open
    );
    
    f_int(4*(digits)-1 downto 4) <= a(4*digits -1 downto 4);

    GEN_CONV: for j in 0 to digits-1 generate
        conv_j: hexDecimal
        port map (
            hexa    => f_int(4*j + 3 downto 4*j),
            Cin     => carry(j),
            dec     => F(4*j + 3 downto 4*j),
            Cout    => carry(j+1)
        );
    end generate GEN_CONV;
end architecture estrutural;