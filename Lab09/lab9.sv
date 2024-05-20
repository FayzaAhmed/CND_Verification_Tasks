program automatic mytest;
	import uvm_pkg::*; 
	class my_test extends uvm_test;
	`uvm_component_utils(my_test)
 // constructor
	function new(string name = "my_test", uvm_component parent = null);
		super.new(name, parent); 
	endfunction

	virtual task run_phase(uvm_phase phase);
 		phase.raise_objection(this);
 			`uvm_info(get_type_name, "Hello Horld <333", UVM_LOW);
 		phase.drop_objection(this);
 	endtask
 endclass

 initial run_test();
 endprogram 
//Compile using: vcs -sverilog -ntb_opts uvm-1.2 lab8.sv 
// ./simv +UVM_TESTNAME=my_test
