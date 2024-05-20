
// TOP module
module top ;
  bit clk;
  
always  #5 clk = ~clk;
//   interface instance
  arbiter_io INT (clk);
//   program instance
  test tb (INT);
//   design instance
  arb_with_port dut(INT);
  
  initial begin
      $dumpfile("outfile.vcd");
      $dumpvars;
  end

endmodule
