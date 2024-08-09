transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/TDD_P2_Sumador/Sumador4bits.vhd}
vcom -93 -work work {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/TDD_P2_Sumador/sumador1bit.vhd}
vcom -93 -work work {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/TDD_P2_Sumador/bin_to_bcd.vhd}
vcom -93 -work work {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/TDD_P2_Sumador/bcd_to_7seg.vhd}
vcom -93 -work work {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/TDD_P2_Sumador/top_level.vhd}

vcom -93 -work work {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/TDD_P2_Sumador/Sumador4bits_tb.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev -L rtl_work -L work -voptargs="+acc"  sumador4bits_tb

add wave *
view structure
view signals
run -all
