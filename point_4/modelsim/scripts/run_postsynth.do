vlib work
project new ./ fpmul_post_synth.mpf
project addfile ../hdl/tb/tb_fpmul_reg.v
project addfile ../netlist/fpmul.v
project compileall
vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /tb_fpmul/UUT=../netlist/fpmul.sdf work.tb_fpmul
add wave *
run 2 us
