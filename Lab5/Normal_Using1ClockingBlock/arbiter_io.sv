// interface
interface arbiter_io(input bit clk);
   logic [1:0] grant;
   logic [1:0] request; 
   bit rst;
  
  clocking cb @(posedge clk);
    default input #1 output #2;
    output request ;
    input grant;
  endclocking
  
  modport DUT(input request,rst,clk,output grant);
  modport TB(clocking cb,output rst);
    
endinterface
    

    