
class test_collection extends uvm_test;

`uvm_component_utils(test_collection)
 
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new

env environ;

virtual function void start_of_simulation_phase (uvm_phase phase);
     super.start_of_simulation_phase(phase);
uvm_root::get().print_topology();
uvm_factory::get().print();

endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

  
environ = env::type_id::create("environ",this);
 
 
    
  endfunction: build_phase
endclass
