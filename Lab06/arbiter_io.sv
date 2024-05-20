// interface
`timescale 1ns/1ps
interface arbiter_io(input bit clk);
   logic [1:0] grant;
   logic [1:0] request; 
   bit rst;
  
  clocking cb @(posedge clk);
    //default input #1 output #2;
    output request ;
    input grant;
    
  endclocking
  
  modport DUT(input request,rst,clk,output grant);
  modport TB(clocking cb,output rst);
    


assert property (@(posedge clk) disable iff(rst) (!$isunknown(request)))

	 	
	$display("\n\nrequest has a valueeeeeeeeee");
else
		$display("\nrequest has XXXXXXXXXXXXXXXXXXXXXXXZZZZZZZZZZZZZZZZ");


endinterface
    


