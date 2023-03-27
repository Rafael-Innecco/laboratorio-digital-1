onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /jogo_desafio_ritmo_tb_modo_escrita/clk_in
add wave -noupdate /jogo_desafio_ritmo_tb_modo_escrita/rst_in
add wave -noupdate /jogo_desafio_ritmo_tb_modo_escrita/jogar_in
add wave -noupdate /jogo_desafio_ritmo_tb_modo_escrita/botoes_in
add wave -noupdate /jogo_desafio_ritmo_tb_modo_escrita/seletor_modo_in
add wave -noupdate /jogo_desafio_ritmo_tb_modo_escrita/leds_out
add wave -noupdate /jogo_desafio_ritmo_tb_modo_escrita/pronto_out
add wave -noupdate /jogo_desafio_ritmo_tb_modo_escrita/clock_out
add wave -noupdate /jogo_desafio_ritmo_tb_modo_escrita/tem_jogada_out
add wave -noupdate /jogo_desafio_ritmo_tb_modo_escrita/jogada_correta_out
add wave -noupdate /jogo_desafio_ritmo_tb_modo_escrita/caso
add wave -noupdate /jogo_desafio_ritmo_tb_modo_escrita/dut/db_mem_hex
add wave -noupdate /jogo_desafio_ritmo_tb_modo_escrita/dut/db_jogada_hex
add wave -noupdate /jogo_desafio_ritmo_tb_modo_escrita/dut/db_estado_hex
add wave -noupdate /jogo_desafio_ritmo_tb_modo_escrita/dut/db_cont_hex
add wave -noupdate -radix unsigned -radixshowbase 0 /jogo_desafio_ritmo_tb_modo_escrita/dut/pontuacao_hex
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3073369204 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 140
configure wave -valuecolwidth 54
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
WaveRestoreZoom {1322354325 ps} {3782530230 ps}
