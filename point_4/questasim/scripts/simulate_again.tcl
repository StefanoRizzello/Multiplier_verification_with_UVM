project compileall
vlog -sv ../tb/top.sv
vsim -L /software/dk/nangate45/verilog/msim6.2g/ top
add wave -position insertpoint sim:/top/sum/FPmul_under_test/* 
run 10 us

