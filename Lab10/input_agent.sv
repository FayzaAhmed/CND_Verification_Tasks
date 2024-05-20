class input_agent extends uvm_agent;
  // The uvm_sequencer class as defined in the uvm_pkg can be used as is.
  // You need to just parameterize it
  
  `uvm_component_utils(input_agent)
  typedef uvm_sequencer#(seq_item) my_sequencer;
  
  //sequencer and driver instances
  driver drv;
  my_sequencer sqr;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    //TODO: Consruct sequencer and driver components from the instances above
drv = driver::type_id::create("drv",this);
sqr = my_sequencer::type_id::create("sqr",this);
    // Construction of component should always be done through the factory
    // create mechanism.  The name arguement must match the instance name.
    // The parent handle must be set to reference this object.
    
  endfunction: build_phase

  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drv.seq_item_port.connect(sqr.seq_item_export);

  endfunction: connect_phase
endclass: input_agent
