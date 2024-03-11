program automatic test (arbiter_io.TB tb);
      initial
      $display(" DONE!! ");
      initial begin
        tb.rst <=0;
//         #5;
        repeat(1) @(tb.cb);
        tb.rst<=1;
//         #5;
        repeat(1) @(tb.cb);
        
        // generate the signals:
        tb.rst <=0; //grant = 0
        repeat(2) @(tb.cb);
        tb.cb.request <= 'b10; //grant = 1
//         #10;
        repeat(2) @(tb.cb);
        tb.cb.request <= 'b11;//grant = 0
//         #10;
        repeat(2) @(tb.cb);
        tb.cb.request <= 'b01; //grant = 1
//         #10;
        repeat(2) @(tb.cb);
        tb.cb.request <= 'b00; //grant = 1
        
        end
endprogram 
    
    

