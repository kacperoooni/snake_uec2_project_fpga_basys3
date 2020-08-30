
`timescale 1 ns / 1 ps

module tester;

  // Declare wires to be driven by the outputs
  // of the design, and regs to drive the inputs.
  // The testbench will be in control of inputs
  // to the design, and will check the outputs.
  // Then, instantiate the design to be tested.

  reg clk;
  wire vsync, hsync;
  wire [3:0] r, g, b;
  wire rst_sim;
  assign rst_sim = 0;
  reg [3:0] key = 4'b0100; 
 
  // Instantiate the vga_example module.
  
  MAIN MAIN (
    .clk(clk),
    .vsync(vsync),
    .hsync(hsync),
    .r(r),
    .g(g),
    .b(b),
	.rst(rst_sim),
	.key(key)
  );

  // Instantiate the tiff_writer module.



  // Describe a process that generates a clock
  // signal. The clock is 100 MHz.

  always
  begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
  end
 initial
   begin
   $display("If simulation ends before the testbench");
   $display("completes, use the menu option to run all.");
   $display("Prepare to wait a long time...");
   wait (vsync == 1'b0);
   @(negedge vsync) $display("Info: negedge VS at %t",$time);
   @(negedge vsync) $display("Info: negedge VS at %t",$time);
     // End the simulation.
   $display("Simulation is over, check the waveforms.");
   $stop;
  end
 
 endmodule  
