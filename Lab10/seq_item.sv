 

class seq_item extends uvm_sequence_item;
  rand bit [3:0] sa, da;
  rand bit[7:0] payload[$];
 
  `uvm_object_utils_begin(seq_item)
    `uvm_field_int(sa, UVM_ALL_ON | UVM_NOCOMPARE)
    `uvm_field_int(da, UVM_ALL_ON)
    `uvm_field_queue_int(payload, UVM_ALL_ON)
  `uvm_object_utils_end
  
function new(string name = "seq_item");
super.new(name);
endfunction
endclass
