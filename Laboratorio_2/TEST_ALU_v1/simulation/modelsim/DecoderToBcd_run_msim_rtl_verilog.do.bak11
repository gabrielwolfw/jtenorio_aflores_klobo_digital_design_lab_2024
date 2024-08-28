transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD {C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD/alu.sv}
vlog -sv -work work +incdir+C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD {C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD/adder.sv}
vlog -sv -work work +incdir+C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD {C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD/multiplier.sv}
vlog -sv -work work +incdir+C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD {C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD/substractor.sv}
vlog -sv -work work +incdir+C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD {C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD/full_adder.sv}
vlog -sv -work work +incdir+C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD {C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD/top.sv}
vlog -sv -work work +incdir+C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD {C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD/bin_to_7seg.sv}

vlog -sv -work work +incdir+C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD {C:/Users/killt/Desktop/Taller_Digitales/DecoderToBCD/alu_tb.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  alu_tb

add wave *
view structure
view signals
run -all
