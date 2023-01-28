onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Inputs
add wave -noupdate -label clock /circuito_exp3_tb/clock_in
add wave -noupdate -label reset /circuito_exp3_tb/reset_in
add wave -noupdate -label iniciar /circuito_exp3_tb/iniciar_in
add wave -noupdate -label chaves /circuito_exp3_tb/chaves_in
add wave -noupdate -divider Outputs
add wave -noupdate -label pronto /circuito_exp3_tb/pronto_out
add wave -noupdate -label igual /circuito_exp3_tb/db_igual_out
add wave -noupdate -label db_contagem /circuito_exp3_tb/dut/db_contagemhex
add wave -noupdate -label db_memoria /circuito_exp3_tb/dut/db_memoriahex
add wave -noupdate -label db_chaves /circuito_exp3_tb/dut/db_chaveshex
add wave -noupdate -label db_estado /circuito_exp3_tb/dut/db_estadohex
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1176 ns} 0} {{Cursor 2} {120 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 157
configure wave -valuecolwidth 101
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
WaveRestoreZoom {0 ns} {1255 ns}
