transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/alu.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/adder.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/multiplier.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/substractor.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/full_adder.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/top.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/bin_to_7seg.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/operation_selector.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/partial_multiplier.sv}

vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/alu_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  alu_tb

add wave *
view structure
view signals
run -all
