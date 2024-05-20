
program automatic test;
 
import uvm_pkg::*; 

`include "seq_item.sv"
`include "driver.sv"
`include "input_agent.sv"
`include "env.sv"
`include "test_collection.sv"
initial
begin
$timeformat (-9,1,"ns",10);
run_test("test_collection");
end

endprogram
