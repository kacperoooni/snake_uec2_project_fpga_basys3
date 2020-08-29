`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2020 19:15:48
// Design Name: 
// Module Name: VGA_rgb_controller
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


module VGA_rgb_controller(
    input wire [15:0] hcount_in,
    input wire hsync_in,
    input wire hblnk_in,
    input wire [15:0] vcount_in,
    input wire vsync_in,
    input wire vblnk_in,
    input wire clk,
    input wire rst,

    output reg [11:0] rgb_out,
    output wire vsync_out,
    output wire hsync_out,
    output reg [15:0] vcount_out,
    output reg [15:0] hcount_out    
    );
    
    assign vsync_out = vsync_in;
    assign hsync_out = hsync_in;
    
    
     reg [11:0] rgb_nxt;
     
     always @(posedge clk or posedge rst)
     begin
     if (rst) 
        begin
        rgb_out <= 0;               
        end    
     else     
        begin
        rgb_out <= rgb_nxt;
        vcount_out <= vcount_in;
        hcount_out <= hcount_in;
        end
     end
     
             
           
     always @(*)
     begin
       // Just pass these through.
       // During blanking, make it it black.
       if (vblnk_in || hblnk_in) rgb_nxt <= 12'h0_0_0; 
       else
       begin
       
       //BACKGROUND HERE
       
         // Active display, top edge, make a yellow line.
         if (vcount_in == 0) rgb_nxt <= 12'hf_f_0;
         // Active display, bottom edge, make a red line.
         else if (vcount_in == 767) rgb_nxt <= 12'hf_0_0;
         // Active display, left edge, make a green line.
         else if (hcount_in == 0) rgb_nxt <= 12'h0_f_0;
         // Active display, right edge, make a blue line.
         else if (hcount_in == 1022) rgb_nxt <= 12'h0_0_f;
         // Active display, interior, fill with gray.
         // You will replace this with your own test.
         else rgb_nxt <= 12'h0_0_0;    
        
       end
       
     end
    
     
    
endmodule