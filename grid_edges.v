`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.08.2020 15:03:55
// Design Name: 
// Module Name: grid_edges
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


module grid_edges(
	input wire clk,
	input wire [11:0] rgb_in,
	input wire [15:0] vcount_in,hcount_in,
	input wire vsync_in,hsync_in,
	
	output reg [15:0] vcount_out,hcount_out,
	output reg hsync_out,vsync_out,
	output reg [11:0] rgb_out
	
    );
    
reg [11:0] rgb_nxt;    
wire [5:0] X,Y;
assign X = (hcount_in/16'd32);
assign Y = (vcount_in/16'd32);    
    
parameter EDGE_WIDTH = 2; 

always@(*)
				begin
						rgb_nxt = rgb_in;
						//for(X=0;X<=32;X=X+1)
					//		begin
		
								if ((hcount_in >= X*32 && hcount_in <= X*32 + EDGE_WIDTH) ^^ (hcount_in >= X*32 + 32-EDGE_WIDTH && hcount_in <= X*32 + 32)) rgb_nxt = 12'h0_0_0; 
								if ((vcount_in >= Y*32 && vcount_in <= Y*32 + EDGE_WIDTH) ^^ (vcount_in >= Y*32 + 32-EDGE_WIDTH && vcount_in <= Y*32 + 32)) rgb_nxt = 12'h0_0_0; 
					//		end	
			/*			for(Y=0;Y<=24;Y=Y+1)
							begin		
								if((vcount_in >= Y*32 && vcount_in <= Y*32 + 5) ^^ (vcount_in >= Y*32 + 27 && vcount_in <= Y*32 + 32)) rgb_nxt = 12'h0_0_0;
							end	
    */				
    		end



always@(posedge clk)
	begin
		rgb_out <= rgb_nxt;
		vsync_out <= vsync_in;
		hsync_out <= hsync_in;
		vcount_out <= vcount_in;
		hcount_out <= hcount_in;
	end	
	
endmodule	