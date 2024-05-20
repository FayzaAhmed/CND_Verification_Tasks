module FSM ( input  in,
            input  clk, 
            input  reset,
            output reg [2:0] out );
  
  typedef enum { S0=0, S1, S2, S3} states;
  states current_state, next_state;
  
  always @(posedge clk, posedge reset) begin
    if(reset)   current_state<= S0;
    else        current_state<=next_state;
  end 
  
  
  always @(*) begin
    
    case(current_state)
      S0: begin
        if(in==1)   next_state = S1;
        else        next_state =S0;
      end
      S1: begin
        next_state =S2; 
      end      
      S2: begin
        if(in==1)   next_state = S3;
        else        next_state =S1;
      end
      S3: begin
          next_state =S0; 
      end 
      default: next_state= S0;      
    endcase
  end
      
      
      
always @(*)  begin 
        
  case(current_state)       
    S0: out=3'b000;
    S1: out=3'b001;
    S2: out=3'b011;
    S3: out=3'b111;
    default: out=3'b000;
  endcase
end
          

endmodule


