onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/leds_out
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/fluxo_dadosFD/leds
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/fluxo_dadosFD/led_intermediario1
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/fluxo_dadosFD/led_intermediario2
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/fluxo_dadosFD/memoria_jogada_fixa/next_data
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/fluxo_dadosFD/memoria_jogada_alternativa/next_data
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
WaveRestoreZoom {0 ns} {2441 ns}
