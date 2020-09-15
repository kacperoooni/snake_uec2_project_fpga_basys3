`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2020 19:59:47
// Design Name: 
// Module Name: key_debouncer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module key_debouncer(
	input wire clk,
	input wire rst,
	input wire rx_empty,
	input wire [7:0] r_data,
	output wire [7:0] r_data_debug,
	output reg [7:0] key_data 
    );
    
  localparam
  INIT = 0,
  KEY_PRESSED = 1,
  KEY_RELASED = 2;
  assign r_data_debug = r_data;
  reg [3:0] state, state_nxt;
  reg [7:0] key_data_nxt;
//  assign r_data_debug = key_data;  
    
 always@*
 	begin
    if(rx_empty == 0)
    	begin 
    		key_data_nxt = r_data;
    	end
    else if(rst)
    	begin
    		key_data_nxt = 0;
    	end		
    else 
    	begin
    		key_data_nxt = 8'b0;
    	end	
	end
   
 always@(posedge clk)
  begin
  	key_data = key_data_nxt;
  end	
endmodule    