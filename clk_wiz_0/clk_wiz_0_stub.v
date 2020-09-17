// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.3 (win64) Build 2018833 Wed Oct  4 19:58:22 MDT 2017
// Date        : Wed Sep 16 23:49:15 2020
// Host        : DESKTOP-DNFSS87 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub C:/Users/kacpe/Github/uec2_project/src/clk_wiz_0/clk_wiz_0_stub.v
// Design      : clk_wiz_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_wiz_0(clk_65Mhz, reset, locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_65Mhz,reset,locked,clk_in1" */;
  output clk_65Mhz;
  input reset;
  output locked;
  input clk_in1;
endmodule
