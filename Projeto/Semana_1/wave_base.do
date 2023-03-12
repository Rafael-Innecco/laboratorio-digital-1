onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Inputs
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/clk_in
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/rst_in
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/jogar_in
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/botoes_in
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/seletor_modo_in
add wave -noupdate -divider Outputs
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/leds_out
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/pronto_out
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/tem_jogada_out
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/jogada_correta_out
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/db_mem_hex
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/db_jogada_hex
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/db_estado_hex
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/db_cont_hex
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/pontuacao_hex
add wave -noupdate -divider Outros
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/unidade_controleUC/Eatual
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/caso
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/fluxo_dadosFD/contador_tempo/fim
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/fluxo_dadosFD/contador_tempo/IQ
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/fluxo_dadosFD/contador_tempo/conta
add wave -noupdate /jogo_desafio_ritmo_tb_modo_base/dut/fluxo_dadosFD/contaT
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {24009 ns} 0} {{Cursor 2} {622247 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 179
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
WaveRestoreZoom {621989 ns} {622264 ns}
