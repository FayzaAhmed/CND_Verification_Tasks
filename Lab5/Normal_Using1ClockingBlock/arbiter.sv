// Code your design here
module arb_with_port(arbiter_io.DUT dut);

  always @(posedge dut.clk or posedge dut.rst) begin 
    if(dut.rst)
      dut.grant <= 2'b00;
    else if (dut.request[0])
  		dut.grant <= 2'b01;
    else if (dut.request[1])
      dut.grant<= 2'b10;
    else
      dut.grant <='0;
  end
  
endmodule

