`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2020 16:06:20
// Design Name: 
// Module Name: char_rom_game_over
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


module char_rom_game_over(
input wire [7:0] char_xy,
input wire clk,
output reg [7:0] char_code
    );
    reg [7:0] addr_x;
    always @(posedge clk)
    begin
    char_code <= addr_x;
    end
    
    always@(*)
    begin
        case (char_xy)
         			8'd12: addr_x = 8'h47; //G
              8'd13: addr_x = 8'h41; //A
              8'd14: addr_x = 8'h4d; //M
              8'd15: addr_x = 8'h45; //E
              8'd16: addr_x = 8'h20; // 
              8'd17: addr_x = 8'h4f; //O 
              8'd18: addr_x = 8'h56; //V
              8'd19: addr_x = 8'h45; //E
              8'd20: addr_x = 8'h52; //R

							8'd72: addr_x = 8'h50; //P	
							8'd73: addr_x = 8'h52; //R	
							8'd74: addr_x = 8'h45; //E	
							8'd75: addr_x = 8'h53; //S	
							8'd76: addr_x = 8'h53; //S
							8'd77: addr_x = 8'h20; // 	
							8'd78: addr_x = 8'h45; //E	
							8'd79: addr_x = 8'h4E; //N	
							8'd80: addr_x = 8'h54; //T	
							8'd81: addr_x = 8'h45; //E
							8'd82: addr_x = 8'h52; //R	
							8'd83: addr_x = 8'h20; //
							8'd84: addr_x = 8'h54; //T	
							8'd85: addr_x = 8'h4f; //O	
							8'd86: addr_x = 8'h20; //	
							8'd87: addr_x = 8'h52; //R
							8'd88: addr_x = 8'h45; //E	
							8'd89: addr_x = 8'h53; //S	
							8'd90: addr_x = 8'h54; //T	
							8'd91: addr_x = 8'h41; //A	
							8'd92: addr_x = 8'h52; //R	
							8'd93: addr_x = 8'h54; //T	
							8'd94: addr_x = 8'h21; //!				
              default: addr_x = 8'h20;					 			   
        endcase
        end
endmodule
