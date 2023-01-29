onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /circuito_exp3_desafio_tb_1/clock_in
add wave -noupdate /circuito_exp3_desafio_tb_1/reset_in
add wave -noupdate /circuito_exp3_desafio_tb_1/iniciar_in
add wave -noupdate /circuito_exp3_desafio_tb_1/chaves_in
add wave -noupdate /circuito_exp3_desafio_tb_1/pronto_out
add wave -noupdate /circuito_exp3_desafio_tb_1/acertou_out
add wave -noupdate /circuito_exp3_desafio_tb_1/errou_out
add wave -noupdate /circuito_exp3_desafio_tb_1/db_igual_out
add wave -noupdate /circuito_exp3_desafio_tb_1/dut/db_chaveshex
add wave -noupdate /circuito_exp3_desafio_tb_1/dut/db_contagemhex
add wave -noupdate /circuito_exp3_desafio_tb_1/dut/db_memoriahex
add wave -noupdate /circuito_exp3_desafio_tb_1/dut/db_estadohex
add wave -noupdate /circuito_exp3_desafio_tb_1/dut/unidade_controleUC/Eatual
add wave -noupdate /circuito_exp3_desafio_tb_1/caso
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1084 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 303
configure wave -valuecolwidth 100
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
WaveRestoreZoom {278 ns} {1175 ns}
