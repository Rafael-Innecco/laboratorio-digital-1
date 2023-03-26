onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/clk_in
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/rst_in
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/jogar_in
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/botoes_in
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/seletor_modo_in
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/leds_out
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/pronto_out
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/clock_out
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/tem_jogada_out
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/jogada_correta_out
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/caso
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/db_mem_hex
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/db_jogada_hex
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/db_estado_hex
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/db_cont_hex
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/pontuacao_hex
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {86450000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 122
configure wave -valuecolwidth 112
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {301219252 ps}
