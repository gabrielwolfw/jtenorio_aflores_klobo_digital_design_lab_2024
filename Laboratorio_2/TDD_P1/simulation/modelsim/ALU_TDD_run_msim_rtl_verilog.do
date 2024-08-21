transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/ALU_top.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/ALU_aux.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/CompuertaOR.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/CompuertaNOT.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/CompuertaXOR.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/flags.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/MUX.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/Suma.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/Resta.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/Multiplicacion.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/Division.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/AshiftLeft.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/LshiftLeft.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/AshiftRight.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/LshiftRight.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/7segments.sv}
vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/CompuertaAND.sv}

vlog -sv -work work +incdir+C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1 {C:/Users/tenor/OneDrive/Documentos/Lab1_TDD/jtenorio_aflores_klobo_digital_design_lab_2024/Laboratorio_2/TDD_P1/ALU_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  ALU_tb

add wave *
view structure
view signals
run -all
