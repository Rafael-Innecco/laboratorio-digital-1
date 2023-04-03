onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/botoes
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/buzzer
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/clock
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/db_clock
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/fluxo_dadosFD/clock_interno
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/db_contagem
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/db_estado
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/db_jogada_correta
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/db_jogadafeita
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/db_memoria
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/db_tem_jogada
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/jogar
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/leds
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/pontuacao
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/pronto
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/reset
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/seletor_modo
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/fluxo_dadosFD/clock_generator_1/fim
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/fluxo_dadosFD/clock_generator_1/IQ
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/fluxo_dadosFD/clock_generator_1/M
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/fluxo_dadosFD/clock_generator_1/Q
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {700650 ns} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ns} {8800630 ns}
