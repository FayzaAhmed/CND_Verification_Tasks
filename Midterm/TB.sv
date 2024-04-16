`timescale 1ns/1ps
`include "Random.sv"
module TB (intf.tb tb);

	covergroup cg_full ;
    option.per_instance = 1;
    full_cp : coverpoint tb.cb.full {
      bins zero = {0};  
      bins one = {1};   
    }
  endgroup
  

  covergroup cg_empty ;
    option.per_instance = 1;
    empty_cp : coverpoint tb.cb.empty {
      bins zero = {0};  
      bins one = {1};   
    }
  endgroup
	
initial begin
	cg_empty cg_empty_inst =new();
	cg_full cg_full_inst = new();
	Random c1 = new();
	@(tb.cb);
		c1.randomize() with {reset ==1;};
		tb.cb.data_in <= c1.data_in;
		tb.cb.reset <= c1.reset;
		tb.cb.Wr_enable <= c1.Wr_enable;
		tb.cb.Read_enable <= c1.Read_enable;
		//For the sake of full covergroup
		repeat(50) begin
		c1.randomize() with {Wr_enable ==1;};
		tb.cb.data_in <= c1.data_in;
		tb.cb.reset <= c1.reset;
		tb.cb.Wr_enable <= c1.Wr_enable;
		tb.cb.Read_enable <= c1.Read_enable;
		//For the sake of full covergroup
		cg_empty_inst.sample();
		cg_full_inst.sample();
		end
	repeat(1000) begin
		@(tb.cb);
		c1.randomize() with {reset ==0;};
		tb.cb.data_in <= c1.data_in;
		tb.cb.reset <= c1.reset;
		tb.cb.Wr_enable <= c1.Wr_enable;
		tb.cb.Read_enable <= c1.Read_enable;
		cg_empty_inst.sample();
		cg_full_inst.sample();
		
	end
end




endmodule
