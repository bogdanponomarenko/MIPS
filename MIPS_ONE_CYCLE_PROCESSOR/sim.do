#Delete previous units from a 'work' library
if { [file exists "work"] } {
    vdel -all
}

#Create library for storing compiled design units
vlib work

#Compile source code into a 'work' library
vlog  MIPS.v testbench.v  alu.v alu_control.v barrel_shifter.v data_memory.v instruction_memory.v CU.v program_counter.v register_file.v sign_extender.v 

#Invoke the VSIM simulator
vsim -novopt work.tsetbench

#Add objects to Wave window
add wave sim:/testbench/*

#Run the current simulation forever, or until it hits a breakpoint or specified break event.
run -all
