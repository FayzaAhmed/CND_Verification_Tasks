interface intf #(parameter
    ADDR_WIDTH           = 5,
    DATA_WIDTH           = 8,
    fifo_size                   =2**ADDR_WIDTH
  )
(input bit clk);

 bit reset;
    bit Wr_enable;
  logic[DATA_WIDTH-1:0] data_in;
   bit Read_enable;
   bit full;
   bit empty;
 logic [DATA_WIDTH-1:0] data_out;


clocking cb @(posedge clk);
	default input #2 output #3;
	output reset;
	output Wr_enable;
	output data_in;
	output Read_enable;
	input full;
	input empty;
	input data_out;

endclocking

modport dut (input clk, input reset, input Wr_enable, input data_in, input Read_enable, output full, output empty, output data_out);

modport tb (input clk, clocking cb);


endinterface
