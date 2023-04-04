-------------------------------------------------------
--! @file somador_decimal_tb.vhd
--! @brief Template para testbench
--! @author Rafael de A. Innecco
--! @date 2023-03-27
-------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--  A testbench has no ports.
entity somador_decimal_tb is
end entity somador_decimal_tb;
        

architecture testbench of somador_decimal_tb is
    --  Declaration of the component to be tested.
    component somador_decimal is
        generic (
            digits : natural := 3
        );
        port (
            A : in std_logic_vector (4*digits - 1 downto 0);
            B : in std_logic_vector (3 downto 0);
            F : out std_logic_vector (4*digits -1 downto 0)
        );
    end component;
    -- Declaration of signals
    signal a_in, f_out: std_logic_vector(11 downto 0);
    signal b_in : std_logic_vector(3 downto 0);
begin
    -- Component instantiation
    -- DUT = Device Under Test 
    DUT: somador_decimal
    generic map (digits => 3)
    port map (
        A => a_in,
        B => b_in,
        F => f_out
    );
        
    --  This process does the real job.
    stimulus_process: process is
        type pattern_type is record
            --  The inputs of the circuit.
            a : std_logic_vector(11 downto 0);
            b : std_logic_vector(3 downto 0);
            --  The expected outputs of the circuit.
            f : std_logic_vector(11 downto 0);
        end record;
        
        --  The patterns to apply.
        type pattern_array is array (natural range <>) of pattern_type;
        constant patterns : pattern_array :=
            (
                ("000000000000", "0100", "000000000100"),
                ("000000000101", "0100", "000000001001"),
                ("1000" &  "0000" & "0111", "0100", "1000" & "0001" & "0001"),
                ("1000" &  "1001" & "0111", "0100", "1001" & "0000" & "0001"),
                ("0000" &  "1001" & "1001", "0001", "0001" & "0000" & "0000")
            );
    begin
        --  Check each pattern.
        for k in patterns'range loop
            --  Set the inputs.
            a_in <= patterns(k).a;
            b_in <= patterns(k).b;
            --  Wait for the results.
                wait for 5 ns;
            --  Check the outputs.
            assert f_out = patterns(k).f
                report "Wrong dec at " & integer'image(k) & " got : " & integer'image(to_integer(unsigned(f_out))) severity error;
            --
        end loop;
            
        assert false report "end of test" severity note;
            
        --  Wait forever; this will finish the simulation.
        wait;
    end process;
end architecture testbench;