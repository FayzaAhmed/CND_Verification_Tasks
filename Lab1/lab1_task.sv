// Code your testbench here
// or browse Examples
module lab1 ;
  typedef enum {Control,Command,Data} Type;
  
  struct  {
    int ID ;
    time Packet_time;
    int unsigned Data;
    Type Packet_type;
  } Packet ;
  
  bit [4:0] Number_packets = $urandom_range(10,20);
  
  initial begin
    for (int i = 1 ; i <= Number_packets ;i = i+1)
      begin
        if (i == 1) 
          begin
            Packet.Packet_type = Control ;
          end
        else if ( i == 2)
          begin
            Packet.Packet_type = Command ;
          end
        else 
          begin
            Packet.Packet_type = Data ;
          end
        Packet.ID = i;
        Packet.Packet_time = $realtime ;
        Packet.Data = $urandom_range(32'h0,32'hFFFFFFFF);
        #5
        $display("The %d packet is : %p",Packet.ID,Packet);
       
      end
  end
endmodule
        
    