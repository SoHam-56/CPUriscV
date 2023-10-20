TEST_BENCH = register_tb

MODULE = ../src/register.sv

sim:
	@echo "Simulation using IVerilog"
	iverilog -g2012 -o ${TEST_BENCH}.vvp ${TEST_BENCH}.sv
	vvp ${TEST_BENCH}.vvp
	gtkwave ${TEST_BENCH}.vcd

clean:
	@if [ -e ${TEST_BENCH}.vvp ]; then rm ${TEST_BENCH}.vvp; fi
	@if [ -e ${TEST_BENCH}.vcd ]; then rm ${TEST_BENCH}.vcd; fi
	clear