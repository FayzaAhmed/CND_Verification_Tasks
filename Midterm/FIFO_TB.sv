`include "interface.sv"
`include "Random.sv"
`include "FIFO.v"

module tb;
  bit clk;
  logic reset;
  logic Wr_enable;
  logic [DATA_WIDTH-1:0] data_in;
  logic Read_enable;
  logic full;
  logic empty;
  logic [DATA_WIDTH-1:0] data_out;

  Random rand_obj;

  intf #(ADDR_WIDTH, DATA_WIDTH, fifo_size) dut_intf(clk);
  FIFO #(ADDR_WIDTH, DATA_WIDTH, fifo_size) dut (
    .clk(clk),
    .reset(dut_intf.reset),
    .Wr_enable(dut_intf.Wr_enable),
    .data_in(dut_intf.data_in),
    .Read_enable(dut_intf.Read_enable),
    .full(dut_intf.full),
    .empty(dut_intf.empty),
    .data_out(dut_intf.data_out)
  );

  // Coverage
  covergroup cg_full @(posedge clk);
    option.per_instance = 1;
    full_cp : coverpoint full {
      bins zero = {0};  
      bins one = {1};   
    }
  endgroup
  cg_full cg_full_instance;

  covergroup cg_empty @(posedge clk);
    option.per_instance = 1;
    empty_cp : coverpoint empty {
      bins zero = {0};  
      bins one = {1};   
    }
  endgroup
  cg_empty cg_empty_instance;

  // Assertions
  //Assertion1: verify When the Write_enable signal is asserted and the FIFO is not full, the write pointer (write_ptr) should increment.
  property write_ptr_increment;
    @(posedge clk)
    disable iff (reset)
    (Wr_enable && !full) |-> (dut.write_ptr == $past(dut.write_ptr) + 1);
  endproperty

  assert p_write_ptr_increment { write_ptr_increment; };

  //Assertion2: verify When the Read_enable signal is asserted and the FIFO is not empty, the read pointer (read_ptr) should increment.
  property read_ptr_increment;
    @(posedge clk)
    disable iff (reset)
    (Read_enable && !empty) |-> (dut.read_ptr == $past(dut.read_ptr) + 1);
  endproperty

  assert p_read_ptr_increment { read_ptr_increment; };

  initial begin
    // Testbench initialization
    clk = 0;
    forever #5 clk = ~clk;

    reset = 1;
    Wr_enable = 0;
    data_in = 8'b0;
    Read_enable = 0;

    dut_intf.reset <= reset;
    dut_intf.Wr_enable <= Wr_enable;
    dut_intf.data_in <= data_in;
    dut_intf.Read_enable <= Read_enable;

    @(posedge clk);
    reset = 0;
    #10;

    // Random constraint random testing
    rand_obj = new;
    rand_obj.randomize();

    cg_full_instance = new();
    cg_empty_instance = new();

    // Apply random values to the interface signals
    repeat (100) begin
      @(posedge clk);
      dut_intf.Wr_enable <= rand_obj.Wr_enable;
      dut_intf.Read_enable <= rand_obj.Read_enable;
      
      assert (p_write_ptr_increment) else $error("Write pointer increment assertion failed");
      assert (p_read_ptr_increment) else $error("Read pointer increment assertion failed");

      // Apply random data to the fifo
      dut_intf.data_in <= rand_obj.data_in;
    end
    $finish;
  end
endmodule
