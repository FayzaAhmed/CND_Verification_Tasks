class driver extends uvm_driver#(seq_item);
  
 

`uvm_component_utils(driver)
 
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction: new
  virtual task run_phase (uvm_phase phase);

    // Get the sequence_item and drive it to DUT
    forever begin
      seq_item_port.get_next_item(req);
      // Once the request item is retrieved, it is the job of the driver to execute the
      // interface protocol and drive the transaction into the DUT.
      send(req);
      seq_item_port.item_done();
    end
  endtask: run_phase

  virtual task send(seq_item seq1);

    // For this lab, there will be no processing of the request item.  

  endtask: send

  
endclass: driver
