onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /hexdecimal_tb/Cin_in
add wave -noupdate -radix decimal /hexdecimal_tb/Cout_out
add wave -noupdate -radix decimal /hexdecimal_tb/dec_out
add wave -noupdate -radix decimal /hexdecimal_tb/hexa_in
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/Cin_ext
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/dec_ext
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/dec_int
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/dez
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/hexa_2
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/hexa_ext
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/hexa_int
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/lss
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/Ov
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2 ns} 0}
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
WaveRestoreZoom {0 ns} {84 ns}
