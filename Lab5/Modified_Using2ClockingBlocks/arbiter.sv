// Code your design here
module arb_with_port(arbiter_io.DUT dut);

  always @( dut.cb_dut or posedge dut.rst) begin 
    if(dut.rst)
      dut.cb_dut.grant <= 2'b00;
    else if (dut.cb_dut.request[0])
  		dut.cb_dut.grant <= 2'b01;
    else if (dut.cb_dut.request[1])
      dut.cb_dut.grant<= 2'b10;
    else
      dut.cb_dut.grant <='0;
  end
  
endmodule
