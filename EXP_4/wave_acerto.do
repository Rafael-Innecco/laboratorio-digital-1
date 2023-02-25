onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Inputs
add wave -noupdate -color Yellow -label clock /circuito_exp4_tb_acerto/dut/clock
add wave -noupdate -color Yellow /circuito_exp4_tb_acerto/dut/reset
add wave -noupdate -color Yellow /circuito_exp4_tb_acerto/dut/iniciar
add wave -noupdate -color Yellow /circuito_exp4_tb_acerto/dut/chaves
add wave -noupdate -divider Outputs
add wave -noupdate /circuito_exp4_tb_acerto/dut/db_clock
add wave -noupdate /circuito_exp4_tb_acerto/dut/pronto
add wave -noupdate /circuito_exp4_tb_acerto/dut/acertou
add wave -noupdate /circuito_exp4_tb_acerto/dut/errou
add wave -noupdate /circuito_exp4_tb_acerto/dut/leds
add wave -noupdate /circuito_exp4_tb_acerto/dut/db_igual
add wave -noupdate /circuito_exp4_tb_acerto/dut/db_tem_jogada
add wave -noupdate /circuito_exp4_tb_acerto/dut/db_mem_hex
add wave -noupdate /circuito_exp4_tb_acerto/dut/db_cont_hex
add wave -noupdate /circuito_exp4_tb_acerto/dut/db_jogada_hex
add wave -noupdate /circuito_exp4_tb_acerto/dut/db_estado_hex
add wave -noupdate -divider Outros
add wave -noupdate -color {Medium Blue} /circuito_exp4_tb_acerto/dut/unidade_controleUC/Eatual
add wave -noupdate -color {Medium Blue} /circuito_exp4_tb_acerto/caso
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {535 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 160
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
WaveRestoreZoom {0 ns} {985 ns}
