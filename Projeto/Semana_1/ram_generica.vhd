-------------------------------------------------------
--! @file ram_generica.vhd
--! @brief RAM com escrita sincrona
--! @author Rafael de A. Innecco
--! @date 2021-12-01
-------------------------------------------------------

library ieee;
use ieee.numeric_std.all;

entity ram_generica is
    generic (
        addressSize : natural := 4;
        wordSize : natural := 8
    );
    port (
        ck, wr : in std_logic;
        addr : in std_logic_vector (addressSize - 1 downto 0);
        data_i : in std_logic_vector (wordSize - 1 downto 0);
        data_o : out std_logic_vector (wordSize - 1 downto 0)
    );
end ram;

architecture ram_modelsim of ram_generica is
    constant depth : natural := 2**addressSize;
    type mem_tipo is array (0 to depth - 1) of std_logic_vector (wordSize - 1 downto 0);
    signal mem : mem_tipo;
begin

    ESCR: process (ck) is -- Processo de escrita
    begin
        if ck = '1' and wr = '1' then
            mem(to_integer(unsigned(addr))) <= data_i;
        end if;
    end process ESCR;

    data_o <= mem(to_integer(unsigned(addr)));
end architecture arch;


