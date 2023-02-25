onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Inputs
add wave -noupdate -color Yellow -height 30 /circuito_desafio_exp5_tb_erro/dut/clock
add wave -noupdate -color Yellow -height 30 /circuito_desafio_exp5_tb_erro/dut/reset
add wave -noupdate -color Yellow -height 30 /circuito_desafio_exp5_tb_erro/dut/jogar
add wave -noupdate -color Yellow -height 30 /circuito_desafio_exp5_tb_erro/dut/botoes
add wave -noupdate -divider Outputs
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/leds
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/pronto
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/ganhou
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/perdeu
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/db_clock
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/db_tem_jogada
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/db_jogada_correta
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/db_enderecoIgualRodada
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/db_timeout
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/db_mem_hex
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/db_cont_hex
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/db_jogada_hex
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/db_estado_hex
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/db_rodada_hex
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/seletor_leds
add wave -noupdate -color {Green Yellow} -height 30 /circuito_desafio_exp5_tb_erro/dut/escreveM
add wave -noupdate -divider Outros
add wave -noupdate -color red -height 30 /circuito_desafio_exp5_tb_erro/caso
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6783 ns} 0} {{Cursor 2} {21121 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ns} {46535 ns}
