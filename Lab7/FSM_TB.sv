module testbench;
  parameter CLK_PERIOD = 10; // Clock period in time units
  reg in, clk, reset;
  wire [2:0] out;
  
  // Instantiate the FSM module
  FSM fsm (.in(in), .clk(clk), .reset(reset), .out(out));
  
  // Clock generation
  always #((CLK_PERIOD)/2) clk = ~clk;
  
  // Reset generation
  initial begin
    reset = 1;
    #50;  // Wait for 5 clock cycles
    reset = 0;
  end
  
  // Test cases
  initial begin
    clk = 0; 
    in = 0;
    #2; reset=0; #2; reset=1;
    #21; reset=0;
    #9; in=0;
    #9; in=0;
    #10; in=1;

    #2; reset=0; #2; reset=1;
    #21; reset=0;
    #9; in=0;
    #9; in=0;
    #10; in=1;

    #21; reset=0;
    #9; in=1;
    #9; in=1;
    #10; in=0;

    #1000;   
    $finish;
  end
  
  // Cover groups
  covergroup state_coverage @(posedge clk);
    // Cover all states
    coverpoint fsm.current_state {
      bins S0 = {0};
      bins S1 = {1};
      bins S2 = {2};
      bins S3 = {3};
    }
  endgroup
  state_coverage stateGroup;

  covergroup transition_coverage @(posedge clk);
    // Cover all state transitions
    coverpoint {fsm.current_state, fsm.next_state} {
      bins S0_S1 = {0 -> 1};
      bins S0_S2 = {0 -> 2};
      bins S1_S2 = {1 -> 2};
      bins S2_S3 = {2 -> 3};
      bins S3_S0 = {3 -> 0};
    }
  endgroup
  transition_coverage tranGroup;

  covergroup output_coverage @(posedge clk);
    // Cover all output values
    coverpoint out {
      bins OUT_0 = {3'b000};
      bins OUT_1 = {3'b001};
      bins OUT_2 = {3'b011};
      bins OUT_3 = {3'b111};
    }
  endgroup
  output_coverage outGroup;
  // Capture coverage
  initial begin
    stateGroup = new();
    tranGroup = new();
    outGroup = new();
    #1000; // Adjust the simulation time as needed
    $display("Total Coverage = %0.2f %%", $get_coverage);
  end

endmodule
