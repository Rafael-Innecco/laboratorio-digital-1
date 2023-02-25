onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /jogo_desafio_memoria_tb_acerto/clk_in
add wave -noupdate /jogo_desafio_memoria_tb_acerto/rst_in
add wave -noupdate /jogo_desafio_memoria_tb_acerto/jogar_in
add wave -noupdate /jogo_desafio_memoria_tb_acerto/botoes_in
add wave -noupdate /jogo_desafio_memoria_tb_acerto/jogada_correta_out
add wave -noupdate /jogo_desafio_memoria_tb_acerto/ganhou_out
add wave -noupdate /jogo_desafio_memoria_tb_acerto/perdeu_out
add wave -noupdate /jogo_desafio_memoria_tb_acerto/pronto_out
add wave -noupdate /jogo_desafio_memoria_tb_acerto/leds_out
add wave -noupdate /jogo_desafio_memoria_tb_acerto/dut/db_mem_hex
add wave -noupdate /jogo_desafio_memoria_tb_acerto/dut/db_cont_hex
add wave -noupdate /jogo_desafio_memoria_tb_acerto/dut/db_jogada_hex
add wave -noupdate /jogo_desafio_memoria_tb_acerto/dut/db_estado_hex
add wave -noupdate /jogo_desafio_memoria_tb_acerto/dut/db_rodada_hex
add wave -noupdate /jogo_desafio_memoria_tb_acerto/dut/unidade_controleUC/Eatual
add wave -noupdate /jogo_desafio_memoria_tb_acerto/caso
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ns} 0}
quietly wave cursor active 0
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
WaveRestoreZoom {74480 ns} {75480 ns}
