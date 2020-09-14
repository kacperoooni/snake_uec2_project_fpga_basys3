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


module char_rom_menu(
input wire [7:0] char_xy,
input wire [15:0] score_in,
input wire clk,
input wire [1:0] difficulty_level,
input wire [11:0] snake_color,
output reg [7:0] char_code
    );
    reg [7:0] addr_x;
    reg [5:0] char_r,char_g,char_b;
    always @(posedge clk)
    begin
    char_code <= addr_x;
    end
    
    always@(*)
    begin
    	if(snake_color[11:8] > 4'h9) char_r = snake_color[11:8]+4'h7;
    	else char_r = snake_color[11:8];
    	if(snake_color[7:4] > 4'h9) char_g = snake_color[7:4]+4'h7;
    	else char_g = snake_color[7:4];
    	if(snake_color[3:0] > 4'h9) char_b = snake_color[3:0]+4'h7;
    	else char_b = snake_color[3:0];
    	
        case (char_xy)
         			8'h06: addr_x = 8'h4D; //M
              8'h07: addr_x = 8'h45; //E
              8'h08: addr_x = 8'h4E; //N
              8'h09: addr_x = 8'h55; //U
              
              8'd00: addr_x = 8'h43;//C
              8'd16: addr_x = 8'h54;//T
              8'd32: addr_x = 8'h52;//R
              
              8'd21: addr_x = 8'h53;//S
              8'd22: addr_x = 8'h45;//E
              8'd23: addr_x = 8'h54;//T
              8'd24: addr_x = 8'h54;//T
              8'd25: addr_x = 8'h49;//I
              8'd26: addr_x = 8'h4E;//N
              8'd27: addr_x = 8'h47;//G
              
              
              
              8'd48: addr_x = 8'h31;//1
              8'd49: addr_x = 8'h20;//
              8'd50: addr_x = 8'h2D;//-
              8'd51: addr_x = 8'h20;//
              8'd52: addr_x = 8'h44;//D
              8'd53: addr_x = 8'h49;//I
              8'd54: addr_x = 8'h46;//F
              8'd55: addr_x = 8'h46;//F
              8'd56: addr_x = 8'h49;//I
              8'd57: addr_x = 8'h43;//C
              8'd58: addr_x = 8'h55;//U
              8'd59: addr_x = 8'h4C;//L
              8'd60: addr_x = 8'h54;//T
              8'd61: addr_x = 8'h59;//Y
              8'd62: addr_x = 8'h20;//
              8'd63: addr_x = 8'h30+difficulty_level; // DIFF_NUMBER
              
              
              
              8'd80: addr_x = 8'h32; //2
              8'd82: addr_x = 8'h52; //R
              8'd84: addr_x = 8'h30+char_r;
              
              8'd96: addr_x = 8'h33; //3
              8'd98: addr_x = 8'h47; //G
              8'd100: addr_x = 8'h30+char_g;
              
              8'd112: addr_x = 8'h34; //4
              8'd114: addr_x = 8'h42; //B
              8'd116: addr_x = 8'h30+char_b; //B
              
              default: addr_x = 8'h20;					 			   
        endcase
        end
        

    		
    
endmodule

                     