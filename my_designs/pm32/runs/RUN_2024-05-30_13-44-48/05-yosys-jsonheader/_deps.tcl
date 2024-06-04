set ::_synlig_defines [list]
verilog_defines -DPDK_sky130A
lappend ::_synlig_defines +define+PDK_sky130A
verilog_defines "-DSCL_sky130_fd_sc_hd\""
lappend ::_synlig_defines "+define+SCL_sky130_fd_sc_hd\""
verilog_defines -D__openlane__
lappend ::_synlig_defines +define+__openlane__
verilog_defines -D__pnr__
lappend ::_synlig_defines +define+__pnr__
verilog_defines -DUSE_POWER_PINS
lappend ::_synlig_defines +define+USE_POWER_PINS
read_verilog -sv -lib /Users/chukwufumnanyaogbogu/Documents/GitHub/openlane2/my_designs/pm32/runs/RUN_2024-05-30_13-44-48/tmp/82641969e5d04188b5e941d164acf0bd.bb.v
set ::env(SYNTH_LIBS) /Users/chukwufumnanyaogbogu/Documents/GitHub/openlane2/my_designs/pm32/runs/RUN_2024-05-30_13-44-48/tmp/c72e79b548a84a1eb630273a2c31455e.lib
