onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Inputs
add wave -noupdate -height 40 /circuito_exp3_desafio_tb_1/clock_in
add wave -noupdate -height 40 /circuito_exp3_desafio_tb_1/reset_in
add wave -noupdate -height 40 /circuito_exp3_desafio_tb_1/iniciar_in
add wave -noupdate -height 40 /circuito_exp3_desafio_tb_1/chaves_in
add wave -noupdate -divider Outputs
add wave -noupdate -height 40 /circuito_exp3_desafio_tb_1/pronto_out
add wave -noupdate -height 40 /circuito_exp3_desafio_tb_1/acertou_out
add wave -noupdate -height 40 /circuito_exp3_desafio_tb_1/errou_out
add wave -noupdate -height 40 /circuito_exp3_desafio_tb_1/db_igual_out
add wave -noupdate -height 40 -label db_contagem /circuito_exp3_desafio_tb_1/dut/db_contagemhex
add wave -noupdate -height 40 -label db_memoria /circuito_exp3_desafio_tb_1/dut/db_memoriahex
add wave -noupdate -height 40 -label db_chaves /circuito_exp3_desafio_tb_1/dut/db_chaveshex
add wave -noupdate -height 40 -label db_estado /circuito_exp3_desafio_tb_1/dut/db_estadohex
add wave -noupdate -divider Outros
add wave -noupdate -color {Medium Blue} -height 40 -label Estado /circuito_exp3_desafio_tb_1/dut/unidade_controleUC/Eatual
add wave -noupdate -color {Medium Blue} -height 40 /circuito_exp3_desafio_tb_1/caso
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1144 ns} 0} {{Cursor 2} {836 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 109
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
WaveRestoreZoom {836 ns} {1134 ns}
