module seq(
input clk,
  input reset,
  input sig_in,
  output detect
);
  
  reg [2:0] arr;
  
  always @ (posedge clk, posedge reset) begin
    
    if (reset)
      arr <= 0;
    else 
      arr <= {sig_in, arr[2:1]};
    
  end
    
  assign detect = (arr == 3'b110) ;
    
   endmodule

//___________________________________________________________________
//testbench

module tb_seq_dec ;
  
//  section1
  bit input_queue[$]= {0,0,1,1,0,0,0,1,1,0};
  bit detect_golden_queue[$] = {0,0,0,1,0,0,0,0,1,0};
  bit detect_queue[$];
  
  int len=input_queue.size();
	int i=10;
  //DUT instace: 
  reg clk, reset, sig_in;
  wire detect;
  seq DUT (.clk(clk), .reset(reset), .sig_in(sig_in), .detect(detect));
  
//   clk generation
  always  #5 clk= ~clk;
  
  initial begin
//     clk init
    clk = 0;
//     reset insertion
    reset =0; 
    #2;
    reset = 1; #2;
    reset=0;
    
        
    while(input_queue.size() >0) begin
      
      @(posedge clk) begin
        sig_in = input_queue.pop_front(); 
        #3;
      detect_queue.push_back(detect);
              i--;

      end
    end
    
    if(detect_queue == detect_golden_queue) $display("\neslmaaaaaaa wasssss heerrerererer\n");
    else
      $display("xxxxxxxxxxxxxxxxxxxxxxx");
    $finish;
    
  end 
  
endmodule

