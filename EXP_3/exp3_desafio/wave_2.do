onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Inputs
add wave -noupdate -height 40 -label clock /circuito_exp3_desafio_tb_2/clock_in
add wave -noupdate -height 40 -label reset /circuito_exp3_desafio_tb_2/reset_in
add wave -noupdate -height 40 -label iniciar /circuito_exp3_desafio_tb_2/iniciar_in
add wave -noupdate -height 40 -label chaves /circuito_exp3_desafio_tb_2/chaves_in
add wave -noupdate -divider Outputs
add wave -noupdate -height 40 -label pronto /circuito_exp3_desafio_tb_2/pronto_out
add wave -noupdate -height 40 -label acertou /circuito_exp3_desafio_tb_2/acertou_out
add wave -noupdate -height 40 -label errou /circuito_exp3_desafio_tb_2/errou_out
add wave -noupdate -height 40 -label db_igual /circuito_exp3_desafio_tb_2/db_igual_out
add wave -noupdate -height 40 -label db_contagem /circuito_exp3_desafio_tb_2/dut/db_contagemhex
add wave -noupdate -height 40 -label db_memoria /circuito_exp3_desafio_tb_2/dut/db_memoriahex
add wave -noupdate -height 40 -label db_chaves /circuito_exp3_desafio_tb_2/dut/db_chaveshex
add wave -noupdate -height 40 -label db_estado /circuito_exp3_desafio_tb_2/dut/db_estadohex
add wave -noupdate -divider Outros
add wave -noupdate -color {Medium Blue} -height 40 -label Estado /circuito_exp3_desafio_tb_2/dut/unidade_controleUC/Eatual
add wave -noupdate -color {Medium Blue} -height 40 -label Caso /circuito_exp3_desafio_tb_2/caso
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0} {{Cursor 2} {182 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 108
configure wave -valuecolwidth 68
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ns} {182 ns}
