if { [file exists "work"] } {
    vdel -all
}

vlib work

vlog  MIPS.v testbench.v  alu.v alu_control.v barrel_shifter.v data_memory.v \
instruction_memory.v control_unit.v program_counter.v register_file.v \
sign_extender.v 

vsim -novopt work.testbench

add wave -radix b -position insertpoint sim:/testbench/MIPS_i/clk
add wave -radix b -position insertpoint sim:/testbench/MIPS_i/rst
add wave -radix h -position insertpoint sim:/testbench/MIPS_i/pc_curr_addr
add wave -radix h -position insertpoint sim:/testbench/MIPS_i/Instruction
add wave -radix u -position insertpoint sim:/testbench/MIPS_i/dm_addr
add wave -radix u -position insertpoint sim:/testbench/MIPS_i/dm_wdata
add wave -radix u -position insertpoint sim:/testbench/MIPS_i/dm_rdata
add wave -radix u -position insertpoint sim:/testbench/MIPS_i/regfile_addr1
add wave -radix u -position insertpoint sim:/testbench/MIPS_i/regfile_addr2
add wave -radix u -position insertpoint sim:/testbench/MIPS_i/regfile_addr3
add wave -radix u -position insertpoint sim:/testbench/MIPS_i/regfile_rdata1
add wave -radix u -position insertpoint sim:/testbench/MIPS_i/regfile_rdata2
add wave -radix u -position insertpoint sim:/testbench/MIPS_i/regfile_wdata

restart

run -all

view wave