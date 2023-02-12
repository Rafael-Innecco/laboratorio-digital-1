onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Inputs
add wave -noupdate -color yellow -height 30 /circuito_jogo_base_tb_acerto/clk_in
add wave -noupdate -color yellow -height 30 /circuito_jogo_base_tb_acerto/rst_in
add wave -noupdate -color yellow -height 30 /circuito_jogo_base_tb_acerto/jogar_in
add wave -noupdate -color yellow -height 30 /circuito_jogo_base_tb_acerto/botoes_in
add wave -noupdate -divider Outpus
add wave -noupdate -color {Green Yellow} -height 30 /circuito_jogo_base_tb_acerto/clock_out
add wave -noupdate -color {Green Yellow} -height 30 /circuito_jogo_base_tb_acerto/tem_jogada_out
add wave -noupdate -color {Green Yellow} -height 30 /circuito_jogo_base_tb_acerto/leds_out
add wave -noupdate -color {Green Yellow} -height 30 /circuito_jogo_base_tb_acerto/jogada_correta_out
add wave -noupdate -color {Green Yellow} -height 30 /circuito_jogo_base_tb_acerto/endereco_igual_rodada_out
add wave -noupdate -color {Green Yellow} -height 30 /circuito_jogo_base_tb_acerto/ganhou_out
add wave -noupdate -color {Green Yellow} -height 30 /circuito_jogo_base_tb_acerto/perdeu_out
add wave -noupdate -color {Green Yellow} -height 30 /circuito_jogo_base_tb_acerto/pronto_out
add wave -noupdate -color {Green Yellow} -height 30 -label db_jogada /circuito_jogo_base_tb_acerto/dut/db_jogada_hex
add wave -noupdate -color {Green Yellow} -height 30 -label db_contagem /circuito_jogo_base_tb_acerto/dut/db_cont_hex
add wave -noupdate -color {Green Yellow} -height 30 -label db_mem /circuito_jogo_base_tb_acerto/dut/db_mem_hex
add wave -noupdate -color {Green Yellow} -height 30 -label db_rodada /circuito_jogo_base_tb_acerto/dut/db_rodada_hex
add wave -noupdate -color {Green Yellow} -height 30 -label db_estado /circuito_jogo_base_tb_acerto/dut/db_estado_hex
add wave -noupdate -divider Outros
add wave -noupdate -color red -height 30 -radix decimal /circuito_jogo_base_tb_acerto/caso
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {4600 ns} 0} {{Cursor 2} {2048 ns} 0}
quietly wave cursor active 2
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
WaveRestoreZoom {0 ns} {4600 ns}
