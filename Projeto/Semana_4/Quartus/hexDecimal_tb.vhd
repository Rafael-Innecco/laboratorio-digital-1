-------------------------------------------------------
--! @file generic_testbench.vhd
--! @brief Template para testbench
--! @author Rafael de A. Innecco
--! @date 2021-11-10
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--  A testbench has no ports.
entity hexDecimal_tb is
end entity hexDecimal_tb;
        

architecture testbench of hexDecimal_tb is
    --  Declaration of the component to be tested.
    component hexDecimal is
        port (
            hexa    : in std_logic_vector(3 downto 0);
            Cin     : in std_logic;
            dec     : out std_logic_vector (3 downto 0);
            Cout    : out std_logic
        );
    end component;
    -- Declaration of signals
    signal hexa_in, dec_out: std_logic_vector(3 downto 0);
    signal Cin_in, Cout_out: std_logic;
begin
    -- Component instantiation
    -- DUT = Device Under Test 
    DUT: hexDecimal
    port map (
        hexa    => hexa_in,
        Cin     => Cin_in,
        dec     => dec_out,
        Cout    => Cout_out
    );
        
    --  This process does the real job.
    stimulus_process: process is
        type pattern_type is record
            --  The inputs of the circuit.
            hexa    : std_logic_vector(3 downto 0);
            cin     : std_logic;
            --  The expected outputs of the circuit.
            dec     : std_logic_vector(3 downto 0);
            cout    : std_logic;
        end record;
        
        --  The patterns to apply.
        type pattern_array is array (natural range <>) of pattern_type;
        constant patterns : pattern_array :=
            (
                ("0000", '0', "0000", '0'),
                ("0001", '0', "0001", '0'),
                ("0010", '0', "0010", '0'),
                ("0011", '0', "0011", '0'),
                ("0100", '0', "0100", '0'),
                ("0101", '0', "0101", '0'),
                ("0110", '0', "0110", '0'),
                ("0111", '0', "0111", '0'),
                ("1000", '0', "1000", '0'),
                ("1001", '0', "1001", '0'),
                ("1010", '0', "0000", '1'),
                ("1011", '0', "0001", '1'),
                ("1100", '0', "0010", '1'),
                ("1101", '0', "0011", '1'),
                ("1110", '0', "0100", '1'),
                ("1111", '0', "0101", '1'),
                ("0000", '1', "0001", '0'),
                ("0001", '1', "0010", '0'),
                ("0010", '1', "0011", '0'),
                ("0011", '1', "0100", '0'),
                ("0100", '1', "0101", '0'),
                ("0101", '1', "0110", '0'),
                ("0110", '1', "0111", '0'),
                ("0111", '1', "1000", '0'),
                ("1000", '1', "1001", '0'),
                ("1001", '1', "0000", '1'),
                ("1010", '1', "0001", '1'),
                ("1011", '1', "0010", '1'),
                ("1100", '1', "0011", '1'),
                ("1101", '1', "0100", '1'),
                ("1110", '1', "0101", '1'),
                ("1111", '1', "0110", '1')
            );
    begin
        --  Check each pattern.
        for k in patterns'range loop
            --  Set the inputs.
            hexa_in <= patterns(k).hexa;
            Cin_in <= patterns(k).cin;
            --  Wait for the results.
                wait for 5 ns;
            --  Check the outputs.
            assert dec_out = patterns(k).dec
                report "Wrong dec at " & integer'image(k) & " got : " & integer'image(to_integer(unsigned(dec_out))) severity error;
            --
            assert Cout_out = patterns(k).cout
                report "Wrong cout at " & integer'image(k) severity error;
        end loop;
            
        assert false report "end of test" severity note;
            
        --  Wait forever; this will finish the simulation.
        wait;
    end process;
end architecture testbench;
    
    