--------------------------------------------------------------------
-- Arquivo   : hexDecimal.vhd
-- Projeto   : Projeto PCS3635 2023
--------------------------------------------------------------------
-- Descricao :
--    Unidade combinatória que converte um dígito hexadecimal para decimal, com carry out
--------------------------------------------------------------------
-- Revisoes  :
--     Data        Versao  Autor             Descricao
--     10/11/2021  1.0     Rafael Innecco    Versão inicial
--------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity hexDecimal is
    port (
        hexa    : in std_logic_vector (3 downto 0);
        Cin     : in std_logic;
        dec     : out std_logic_vector (3 downto 0);
        Cout    : out std_logic
    );
end entity hexDecimal;

architecture dataflow of hexDecimal is
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

    signal hexa_ext, hexa_int, dec_ext, Cin_ext: std_logic_vector (5 downto 0);
    signal dec_int, hexa_2 : std_logic_vector (5 downto 0);
    signal dez  : std_logic_vector(5 downto 0) := "001010";
    signal Ov, lss   : std_logic;
begin
    hexa_ext <= "00" & hexa;
    Cin_ext <= "00000" & Cin;

    incrementa_hexa: somador
    generic map (
        size => 6
    )
    port map (
        A => hexa_ext,
        B => Cin_ext,
        S => '0',
        F => hexa_int,
        Z => open,
        N => open,
        Ov => Ov,
        Co => open
    );

    hexa_2 <= hexa_int;

    subtrai_dez: somador
    generic map (
        size => 6
    )
    port map (
        A => hexa_2,
        B => dez,
        S => '1',
        F => dec_int,
        Z => open,
        N => lss,
        Ov => open,
        Co => open
    );

    dec_ext <= hexa_2 when lss = '1' else dec_int;

    Cout <= Ov or (not lss);

    dec <= dec_ext(3 downto 0);
end architecture dataflow;