// interface
interface arbiter_io(input bit clk);
   logic [1:0] grant;
   logic [1:0] request; 
   bit rst;
  
  clocking cb @(posedge clk);
    default input #1 output #2;
    output request;
    input grant;
    
  endclocking
  
//   added another clocking block for dut
  clocking cb_dut @(posedge clk);
    default input #1 output #3;
    input request ;
    output grant;
    
  endclocking
  
  modport DUT(input rst, clocking cb_dut);
  modport TB(clocking cb, output rst);
    
endinterface
    
    