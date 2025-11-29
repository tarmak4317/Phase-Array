module Phaser_tb;
  reg clk;
  reg rst;
  reg [3:0] comp1;
  reg [3:0] comp2;
  wire out1;
  wire out2;

  // Instantiate the Phaser module
  Phaser uut (
    .clk(clk),
    .rst(rst),
    .comp1(comp1),
    .comp2(comp2),
    .out1(out1),
    .out2(out2)
  );

  // Clock generation: 10 ns period
  initial begin
  	clk = 0;
  	forever #5 clk = ~clk;
  end

  initial begin
    // Dumpfile setup for GTKWave
    $dumpfile("Phaser_tb.vcd");      // VCD output file
    $dumpvars(0, Phaser_tb);         // Dump all variables in this module

    // Initialize inputs
    rst = 1;
    #20
    rst = 0;
    comp1 = 4'b0100;
    comp2 = 4'b1010;

    // Run simulation for 1000 ns
    #1000;
    $finish;
  end

endmodule
