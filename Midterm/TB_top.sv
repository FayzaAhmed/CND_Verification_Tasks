`timescale 1ns/1ps
//`include "Random.sv"
//`include "interface.sv"


module TB_top ();
	bit clk;
	intf Intf(clk);
    TB tb_dut(Intf);

	FIFO Dut(
	.clk(clk),
	.reset(Intf.reset),
	.Wr_enable(Intf.Wr_enable),
	.data_in(Intf.data_in),
	.Read_enable(Intf.Read_enable),
	.full(Intf.full),
	.empty(Intf.empty),
	.data_out(Intf.data_out));

	always begin
		clk = ~clk; #5;
	end

	// Assertions
  	//Assertion1: verify When the Write_enable signal is asserted and the FIFO is not full, the write pointer (write_ptr) should increment.
	property write_ptr_increment;
	    @(posedge clk)
	    disable iff (Intf.reset)
	    (Intf.Wr_enable && !Intf.full) |=> (Dut.write_ptr == $past(Dut.write_ptr) + 5'b1);
  	endproperty
	p_write_ptr_increment:assert property ( write_ptr_increment ) else $error("Write pointer increment assertion failed");

	//Assertion2: verify When the Read_enable signal is asserted and the FIFO is not empty, the read pointer (read_ptr) should increment.
	  property read_ptr_increment;
	    @(posedge clk)
	    disable iff (Intf.reset)
	    (Intf.Read_enable && !Intf.empty) |=> (Dut.read_ptr == $past(Dut.read_ptr) + 5'b1);
	  endproperty
	  p_read_ptr_increment:assert property (read_ptr_increment) else $error("Write pointer increment assertion failed");

	initial begin
		#10000;
		$finish;
	end

endmodule
