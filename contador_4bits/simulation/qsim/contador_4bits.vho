-- Copyright (C) 2022  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 22.1std.0 Build 915 10/25/2022 SC Lite Edition"

-- DATE "01/14/2023 14:05:35"

-- 
-- Device: Altera 5CEBA4F23C7 Package FBGA484
-- 

-- 
-- This VHDL file should be used for Questa Intel FPGA (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY ALTERA_LNSIM;
LIBRARY CYCLONEV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE ALTERA_LNSIM.ALTERA_LNSIM_COMPONENTS.ALL;
USE CYCLONEV.CYCLONEV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	contador_4bits IS
    PORT (
	clock : IN std_logic;
	clear : IN std_logic;
	load : IN std_logic;
	Q : OUT std_logic_vector(3 DOWNTO 0)
	);
END contador_4bits;

-- Design Ports Information
-- Q[0]	=>  Location: PIN_N1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q[1]	=>  Location: PIN_AA2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q[2]	=>  Location: PIN_Y3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Q[3]	=>  Location: PIN_W2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clear	=>  Location: PIN_AA1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clock	=>  Location: PIN_M16,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- load	=>  Location: PIN_L1,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF contador_4bits IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clock : std_logic;
SIGNAL ww_clear : std_logic;
SIGNAL ww_load : std_logic;
SIGNAL ww_Q : std_logic_vector(3 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \clock~input_o\ : std_logic;
SIGNAL \clock~inputCLKENA0_outclk\ : std_logic;
SIGNAL \clear~input_o\ : std_logic;
SIGNAL \IQ~0_combout\ : std_logic;
SIGNAL \load~input_o\ : std_logic;
SIGNAL \IQ[0]~1_combout\ : std_logic;
SIGNAL \IQ~2_combout\ : std_logic;
SIGNAL \IQ~3_combout\ : std_logic;
SIGNAL \IQ~4_combout\ : std_logic;
SIGNAL IQ : std_logic_vector(3 DOWNTO 0);
SIGNAL \ALT_INV_load~input_o\ : std_logic;
SIGNAL \ALT_INV_clear~input_o\ : std_logic;
SIGNAL ALT_INV_IQ : std_logic_vector(3 DOWNTO 0);

BEGIN

ww_clock <= clock;
ww_clear <= clear;
ww_load <= load;
Q <= ww_Q;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_load~input_o\ <= NOT \load~input_o\;
\ALT_INV_clear~input_o\ <= NOT \clear~input_o\;
ALT_INV_IQ(3) <= NOT IQ(3);
ALT_INV_IQ(2) <= NOT IQ(2);
ALT_INV_IQ(1) <= NOT IQ(1);
ALT_INV_IQ(0) <= NOT IQ(0);

-- Location: IOOBUF_X0_Y19_N56
\Q[0]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => IQ(0),
	devoe => ww_devoe,
	o => ww_Q(0));

-- Location: IOOBUF_X0_Y18_N79
\Q[1]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => IQ(1),
	devoe => ww_devoe,
	o => ww_Q(1));

-- Location: IOOBUF_X0_Y18_N45
\Q[2]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => IQ(2),
	devoe => ww_devoe,
	o => ww_Q(2));

-- Location: IOOBUF_X0_Y18_N62
\Q[3]~output\ : cyclonev_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false",
	shift_series_termination_control => "false")
-- pragma translate_on
PORT MAP (
	i => IQ(3),
	devoe => ww_devoe,
	o => ww_Q(3));

-- Location: IOIBUF_X54_Y18_N61
\clock~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clock,
	o => \clock~input_o\);

-- Location: CLKCTRL_G10
\clock~inputCLKENA0\ : cyclonev_clkena
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	disable_mode => "low",
	ena_register_mode => "always enabled",
	ena_register_power_up => "high",
	test_syn => "high")
-- pragma translate_on
PORT MAP (
	inclk => \clock~input_o\,
	outclk => \clock~inputCLKENA0_outclk\);

-- Location: IOIBUF_X0_Y18_N95
\clear~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clear,
	o => \clear~input_o\);

-- Location: LABCELL_X1_Y18_N33
\IQ~0\ : cyclonev_lcell_comb
-- Equation(s):
-- \IQ~0_combout\ = (!\clear~input_o\ & !IQ(0))

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "1010101000000000101010100000000010101010000000001010101000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_clear~input_o\,
	datad => ALT_INV_IQ(0),
	combout => \IQ~0_combout\);

-- Location: IOIBUF_X0_Y20_N55
\load~input\ : cyclonev_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_load,
	o => \load~input_o\);

-- Location: LABCELL_X1_Y18_N30
\IQ[0]~1\ : cyclonev_lcell_comb
-- Equation(s):
-- \IQ[0]~1_combout\ = ( \load~input_o\ ) # ( !\load~input_o\ & ( \clear~input_o\ ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0101010101010101010101010101010111111111111111111111111111111111",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_clear~input_o\,
	dataf => \ALT_INV_load~input_o\,
	combout => \IQ[0]~1_combout\);

-- Location: FF_X1_Y18_N35
\IQ[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \IQ~0_combout\,
	ena => \IQ[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => IQ(0));

-- Location: LABCELL_X1_Y18_N3
\IQ~2\ : cyclonev_lcell_comb
-- Equation(s):
-- \IQ~2_combout\ = ( !IQ(1) & ( IQ(0) & ( !\clear~input_o\ ) ) ) # ( IQ(1) & ( !IQ(0) & ( !\clear~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010101010101010101010100000000000000000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_clear~input_o\,
	datae => ALT_INV_IQ(1),
	dataf => ALT_INV_IQ(0),
	combout => \IQ~2_combout\);

-- Location: FF_X1_Y18_N5
\IQ[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \IQ~2_combout\,
	ena => \IQ[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => IQ(1));

-- Location: LABCELL_X1_Y18_N42
\IQ~3\ : cyclonev_lcell_comb
-- Equation(s):
-- \IQ~3_combout\ = ( IQ(2) & ( IQ(1) & ( (!\clear~input_o\ & !IQ(0)) ) ) ) # ( !IQ(2) & ( IQ(1) & ( (!\clear~input_o\ & IQ(0)) ) ) ) # ( IQ(2) & ( !IQ(1) & ( !\clear~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010101000001010000010101010000010100000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_clear~input_o\,
	datac => ALT_INV_IQ(0),
	datae => ALT_INV_IQ(2),
	dataf => ALT_INV_IQ(1),
	combout => \IQ~3_combout\);

-- Location: FF_X1_Y18_N44
\IQ[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \IQ~3_combout\,
	ena => \IQ[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => IQ(2));

-- Location: LABCELL_X1_Y18_N54
\IQ~4\ : cyclonev_lcell_comb
-- Equation(s):
-- \IQ~4_combout\ = ( IQ(3) & ( IQ(1) & ( (!\clear~input_o\ & ((!IQ(0)) # (!IQ(2)))) ) ) ) # ( !IQ(3) & ( IQ(1) & ( (!\clear~input_o\ & (IQ(0) & IQ(2))) ) ) ) # ( IQ(3) & ( !IQ(1) & ( !\clear~input_o\ ) ) )

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000101010101010101000000000000010101010101010100000",
	shared_arith => "off")
-- pragma translate_on
PORT MAP (
	dataa => \ALT_INV_clear~input_o\,
	datac => ALT_INV_IQ(0),
	datad => ALT_INV_IQ(2),
	datae => ALT_INV_IQ(3),
	dataf => ALT_INV_IQ(1),
	combout => \IQ~4_combout\);

-- Location: FF_X1_Y18_N56
\IQ[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputCLKENA0_outclk\,
	d => \IQ~4_combout\,
	ena => \IQ[0]~1_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => IQ(3));

-- Location: MLABCELL_X37_Y11_N0
\~QUARTUS_CREATED_GND~I\ : cyclonev_lcell_comb
-- Equation(s):

-- pragma translate_off
GENERIC MAP (
	extended_lut => "off",
	lut_mask => "0000000000000000000000000000000000000000000000000000000000000000",
	shared_arith => "off")
-- pragma translate_on
;
END structure;


