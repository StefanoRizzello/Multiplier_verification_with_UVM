proc elab {} {
source .synopsys_dc.setup
#adding elemts
analyze -f vhdl -lib WORK ../hdl/src/dadda_tree.vhd
analyze -f vhdl -lib WORK ../hdl/src/half_adder.vhd
analyze -f vhdl -lib WORK ../hdl/src/full_adder.vhd
analyze -f vhdl -lib WORK ../hdl/src/MBE_encoder.vhd
analyze -f vhdl -lib WORK ../hdl/src/mbe_multiplier.vhd


set power_preserve_rtl_hier_names true
elaborate MBE_multiplier -arch arch -lib WORK > ./reports/elaborate.txt
#filter contains multiple instances of reg, need to uniquify
uniquify 
#link
ungroup -all -flatten
}

proc synth {clk_var} {
#set clock @argv1+-0.07ns
create_clock -name MY_CLK -period $clk_var clock
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clock MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clock]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
compile
report_timing > reports/report_timing_${clk_var}_ns.txt
report_area > reports/report_area_clk_${clk_var}_ns.txt
report_resources > reports/report_resources_clk_${clk_var}_ns.txt

ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ../netlist/RV32I.sdf
write -f verilog -hierarchy -output ../netlist/mbe_multiplier.v
write_sdc ../netlist/RV32I.sdc

quit
}


elab
synth 7
