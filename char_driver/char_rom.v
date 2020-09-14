`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.04.2020 20:29:39
// Design Name: 
// Module Name: char_rom
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


module char_rom(
input wire [7:0] char_xy,
input wire [15:0] score_in,
input wire clk, game_start,
output reg [7:0] char_code
    );
    reg [7:0] addr_x;
    
    always @(posedge clk)
    begin
    char_code <= addr_x;
    end
    
    always@(*)
    begin
    	if(game_start == 1)
    		begin 
	        case (char_xy)
	         						 8'h00: addr_x = 8'h53; // S
	                     8'h01: addr_x = 8'h43; // C
	                     8'h02: addr_x = 8'h4F; // O
	                     8'h03: addr_x = 8'h52; // R
	                     8'h04: addr_x = 8'h45; // E
	                     8'h05: addr_x = 8'h3a; // :
	                     8'h06: addr_x = 8'h20;
	                     8'h07: addr_x = 8'h30+char_0; //
	                     8'h08: addr_x = 8'h30+char_1; //
	                     8'h09: addr_x = 8'h30+char_2; //
	                     8'h0A: addr_x = 8'h30+char_3; //
	                     8'h0B: addr_x = 8'h30+char_4; //
	                     default: addr_x = 8'h20;       
	        endcase
       	end
      else addr_x = 8'h20;
   	end
        
        wire [3:0] char_0, char_1, char_2, char_3, char_4;
        assign char_0 = score_in/10000; 
        assign char_1 = score_in/1000-(score_in/10000)*10; 
        assign char_2 = score_in/100-(score_in/1000)*10; 
        assign char_3 = score_in/10-(score_in/100)*10; 
        assign char_4 = score_in-(score_in/10)*10;; 
    
    
endmodule
