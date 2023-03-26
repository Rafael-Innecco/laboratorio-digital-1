onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/incrementa_hexa/A
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/incrementa_hexa/B
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/incrementa_hexa/B_int
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/incrementa_hexa/CA
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/incrementa_hexa/Co
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/incrementa_hexa/F
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/incrementa_hexa/N
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/incrementa_hexa/Ov
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/incrementa_hexa/S
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/incrementa_hexa/SAI
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/incrementa_hexa/size
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/incrementa_hexa/Z
add wave -noupdate -divider Subtrai
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/subtrai_dez/A
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/subtrai_dez/B
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/subtrai_dez/B_int
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/subtrai_dez/CA
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/subtrai_dez/Co
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/subtrai_dez/F
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/subtrai_dez/N
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/subtrai_dez/Ov
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/subtrai_dez/S
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/subtrai_dez/SAI
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/subtrai_dez/size
add wave -noupdate -radix decimal /hexdecimal_tb/DUT/subtrai_dez/Z
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
WaveRestoreZoom {0 ns} {168 ns}
