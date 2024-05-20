`include "write_sequence.sv"
class wr_rd_sequence extends uvm_sequence#(mem_seq_item);

  //--------------------------------------- 
  //Declaring sequences
  //---------------------------------------
  write_sequence wr_seq;
  read_sequence  rd_seq;

  `uvm_object_utils(wr_rd_sequence)

  //--------------------------------------- 
  //Constructor
  //---------------------------------------
  function new(string name = "wr_rd_sequence");
    super.new(name);
  endfunction

  virtual task body();
    repeat (20) begin
      `uvm_do(wr_seq)
    end
    repeat (20) begin
      `uvm_do(rd_seq)
    end
  endtask
endclass
