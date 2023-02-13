onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /circuito_jogo_base_tb_erro/dut/clock
add wave -noupdate /circuito_jogo_base_tb_erro/dut/reset
add wave -noupdate /circuito_jogo_base_tb_erro/dut/jogar
add wave -noupdate /circuito_jogo_base_tb_erro/dut/botoes
add wave -noupdate /circuito_jogo_base_tb_erro/dut/leds
add wave -noupdate /circuito_jogo_base_tb_erro/dut/pronto
add wave -noupdate /circuito_jogo_base_tb_erro/dut/ganhou
add wave -noupdate /circuito_jogo_base_tb_erro/dut/perdeu
add wave -noupdate /circuito_jogo_base_tb_erro/dut/db_clock
add wave -noupdate /circuito_jogo_base_tb_erro/dut/db_tem_jogada
add wave -noupdate /circuito_jogo_base_tb_erro/dut/db_jogada_correta
add wave -noupdate /circuito_jogo_base_tb_erro/dut/db_enderecoIgualRodada
add wave -noupdate /circuito_jogo_base_tb_erro/dut/db_timeout
add wave -noupdate /circuito_jogo_base_tb_erro/dut/db_mem_hex
add wave -noupdate /circuito_jogo_base_tb_erro/dut/db_cont_hex
add wave -noupdate /circuito_jogo_base_tb_erro/dut/db_jogada_hex
add wave -noupdate /circuito_jogo_base_tb_erro/dut/db_estado_hex
add wave -noupdate /circuito_jogo_base_tb_erro/dut/db_rodada_hex
add wave -noupdate /circuito_jogo_base_tb_erro/dut/espera_inicializacao
add wave -noupdate /circuito_jogo_base_tb_erro/caso
add wave -noupdate /circuito_jogo_base_tb_erro/dut/unidade_controleUC/Eatual
add wave -noupdate /circuito_jogo_base_tb_erro/dut/unidade_controleUC/espera_inicializacao
add wave -noupdate /circuito_jogo_base_tb_erro/dut/fluxo_dadosFD/umQuinto
add wave -noupdate /circuito_jogo_base_tb_erro/dut/fluxo_dadosFD/contador_timeout/umQuinto
add wave -noupdate /circuito_jogo_base_tb_erro/dut/fluxo_dadosFD/contaTempo
add wave -noupdate /circuito_jogo_base_tb_erro/dut/fluxo_dadosFD/contador_timeout/conta
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {97 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 156
configure wave -valuecolwidth 87
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
WaveRestoreZoom {0 ns} {3093 ns}
