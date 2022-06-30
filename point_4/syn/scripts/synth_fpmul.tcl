proc elab {} {
source .synopsys_dc.setup
#adding elemts
analyze -f vhdl -lib WORK ../hdl/src/fpmul_stage2_struct_mbe.vhd
analyze -f vhdl -lib WORK ../hdl/src/dadda_tree.vhd
analyze -f vhdl -lib WORK ../hdl/src/full_adder.vhd
analyze -f vhdl -lib WORK ../hdl/src/mbe_multiplier.vhd
analyze -f vhdl -lib WORK ../hdl/src/ff.vhd
analyze -f vhdl -lib WORK ../hdl/src/half_adder.vhd
analyze -f vhdl -lib WORK ../hdl/src/reg.vhd
analyze -f vhdl -lib WORK ../hdl/src/fpmul_pipeline_reg.vhd
analyze -f vhdl -lib WORK ../hdl/src/MBE_encoder.vhd
analyze -f vhdl -lib WORK ../hdl/src/common/fpmul_stage1_struct.vhd
analyze -f vhdl -lib WORK ../hdl/src/common/fpmul_stage4_struct.vhd 
analyze -f vhdl -lib WORK ../hdl/src/common/packfp_packfp.vhd
analyze -f vhdl -lib WORK ../hdl/src/common/fpmul_stage2_struct.vhd
analyze -f vhdl -lib WORK ../hdl/src/common/fpnormalize_fpnormalize.vhd
analyze -f vhdl -lib WORK ../hdl/src/common/unpackfp_unpackfp.vhd
analyze -f vhdl -lib WORK ../hdl/src/common/fpmul_stage3_struct.vhd
analyze -f vhdl -lib WORK ../hdl/src/common/fpround_fpround.vhd                     

set power_preserve_rtl_hier_names true
elaborate FPmul -arch pipeline -lib WORK > ./reports/elaborate.txt
#filter contains multiple instances of reg, need to uniquify
uniquify 
#link
ungroup -all -flatten
}

proc synth {clk_var} {
#set clock @argv1+-0.07ns
create_clock -name MY_CLK -period $clk_var clk
set_dont_touch_network MY_CLK
set_clock_uncertainty 0.07 [get_clock MY_CLK]
set_input_delay 0.5 -max -clock MY_CLK [remove_from_collection [all_inputs] clk]
set_output_delay 0.5 -max -clock MY_CLK [all_outputs]
set OLOAD [load_of NangateOpenCellLibrary/BUF_X4/A]
set_load $OLOAD [all_outputs]
compile
report_timing > reports/report_timing_${clk_var}_ns.txt
report_area > reports/report_area_clk_${clk_var}_ns.txt
report_resources > reports/report_resources_clk_${clk_var}_ns.txt

ungroup -all -flatten
change_names -hierarchy -rules verilog
write_sdf ../netlist/fpmul.sdf
write -f verilog -hierarchy -output ../netlist/fpmul.v
write_sdc ../netlist/fpmul.sdc

quit
}


elab
synth 20
