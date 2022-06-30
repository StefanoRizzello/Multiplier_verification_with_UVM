vlib work
project new ./ mbe_multiplier_proj.mpf
project addfile ../hdl/src/fpmul_stage2_struct_mbe.vhd
project addfile ../hdl/src/MBE_multiplier_tb.vhd
project addfile ../hdl/src/dadda_tree.vhd
project addfile ../hdl/src/full_adder.vhd
project addfile ../hdl/src/mbe_multiplier.vhd
project addfile ../hdl/src/ff.vhd
project addfile ../hdl/src/half_adder.vhd
project addfile ../hdl/src/reg.vhd
project addfile ../hdl/src/fpmul_pipeline_reg.vhd
project addfile ../hdl/src/MBE_encoder.vhd
project addfile ../hdl/src/common/fpmul_stage1_struct.vhd
project addfile ../hdl/src/common/fpmul_stage4_struct.vhd 
project addfile ../hdl/src/common/packfp_packfp.vhd
project addfile ../hdl/src/common/fpmul_stage2_struct.vhd
project addfile ../hdl/src/common/fpnormalize_fpnormalize.vhd
project addfile ../hdl/src/common/unpackfp_unpackfp.vhd
project addfile ../hdl/src/common/fpmul_stage3_struct.vhd
project addfile ../hdl/src/common/fpround_fpround.vhd

project addfile ../hdl/tb/clk_gen.vhd
project addfile ../hdl/tb/data_maker.vhd 
project addfile ../hdl/tb/data_sink.vhd
project addfile ../hdl/tb/data_sink_stage2_opt.vhd 
project addfile ../hdl/tb/tb_fpmul_reg.v

project compileall
# vsim -L /software/dk/nangate45/verilog/msim6.2g -sdftyp /mbe_multiplier_tb/dut=../netlist/mbe_multiplier.sdf work.mbe_multiplier_tb
# add wave *
# run 2 us
