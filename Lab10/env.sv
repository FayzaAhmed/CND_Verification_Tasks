class env extends uvm_env;

  // Environment class should instantiate all required agents.
  input_agent i_agt;

  `uvm_component_utils(env)
 
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //TODO: construct the agent component from the given instance

  
i_agt = input_agent::type_id::create("i_agt",this);
 
    // All components should be constructed using the factory create() method
    
  endfunction: build_phase
  
endclass: env
