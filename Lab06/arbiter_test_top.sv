`timescale 1ns/1ps
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
  
  
// //   monitoring the signals
  initial begin
      $dumpfile("outfile.vcd");
        $dumpvars;
  end
//     $monitor ("request value: %0b, \tgrant Value: %0b ",INT.cb.request, INT.cb.grant );

endmodule
