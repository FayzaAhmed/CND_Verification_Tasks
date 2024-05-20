    
//     prog
`timescale 1ns/1ps
program automatic test (arbiter_io.TB tb);

      initial begin
        tb.rst <=0;
        
        repeat(1) @(tb.cb);
        tb.rst<=1;
        
        repeat(1) @(tb.cb);
        
        // generate the signals:
        tb.rst <=0; //grant = 0
        repeat(2) @(tb.cb);
	assert (tb.cb.grant==0)
		$display("\n1st case passed");
		else $display("\n1st case FAIIIILLLLEEEEDDDD");
		
        tb.cb.request <= 'b10; //grant = 10
        repeat(2) @(tb.cb);
	assert (tb.cb.grant==2'b10)
		$display("\n2nd case passed");
		else $display("\n2nd case FAIIIILLLLEEEEDDDD");
		

        tb.cb.request <= 'b11;//grant = 01
        repeat(2) @(tb.cb);
	assert (tb.cb.grant==2'b01)
		$display("\n3rd case passed");
		else $display("\n3rd case FAIIIILLLLEEEEDDDD");
		

        tb.cb.request <= 'b01; //grant = 01
        repeat(2) @(tb.cb);
	assert (tb.cb.grant==2'b01)
		$display("\n4th case passed");
		else $display("\n4th case FAIIIILLLLEEEEDDDD");
		

        tb.cb.request <= 'b00; //grant = 00
        repeat(2) @(tb.cb);
	assert (tb.cb.grant==0)
		$display("\n5th case passed");
		else $display("\n5th case FAIIIILLLLEEEEDDDD");
		

 
        end
    endprogram 
    
    

