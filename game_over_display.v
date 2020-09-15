`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.09.2020 15:47:51
// Design Name: 
// Module Name: game_over_display
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


module game_over_display(
		input wire clk,
		input wire rst,
		input wire [7:0] key,
		input wire [15:0] vcount, hcount,
		output reg [15:0] vcount_out, hcount_out,
		input wire vsync_in,hsync_in,
		output reg hsync_out,vsync_out,
		input wire [11:0] rgb_in,
		output reg [11:0] rgb_out,
		input wire game_over,
		output reg game_restart
    );
    
    localparam
    INIT = 0,
    WAIT_FOR_EVENT = 1,
    GAME_RESTART = 2,
    GAME_OVER = 3,
    WAIT = 4;
    
    localparam
    KEY_1 = 8'h31,
    KEY_2 = 8'h32,
    KEY_3 = 8'h33,
    KEY_4 = 8'h34,
    ESC = 8'h1b,
    ENTER= 8'h0d;
    
    reg [3:0] state_nxt,state;
    
    reg game_restart_nxt;
    wire [15:0] vcount_nxt, hcount_nxt;
   	wire vsync_nxt, hsync_nxt;
   	reg [11:0] rgb_nxt;
   	wire [11:0] rgb_rect;
    
    
    always@(*)
			begin
				state_nxt = INIT;
				game_restart_nxt = game_restart;
				rgb_nxt = rgb_in_delayed;    
    		case(state)
    			INIT:
    				begin
	    				game_restart_nxt = 0;
	    				state_nxt = WAIT;
    				end
    			WAIT:
    				begin
    					state_nxt = WAIT_FOR_EVENT;
    				end	
    			WAIT_FOR_EVENT:
    				begin
	    				if(game_over == 1) state_nxt = GAME_OVER;	
	    				else state_nxt = WAIT_FOR_EVENT;
	    			end	
    			GAME_RESTART:
    				begin
    					game_restart_nxt = 1;
    					state_nxt = INIT;
    				end
    			GAME_OVER:
    				begin
    					if(key == ENTER) state_nxt = GAME_RESTART;
    					else state_nxt = GAME_OVER;
    					rgb_nxt = rgb_rect;
    				end		
    		endcase
    		if(rst) state_nxt = INIT;	
			end

		always@(posedge clk)
    	begin
    		game_restart <= game_restart_nxt;
    		state <= state_nxt;
    		rgb_out <= rgb_nxt;
   			vcount_out <= vcount_nxt;
   			hcount_out <= hcount_nxt;
   			vsync_out <= vsync_nxt;
    		hsync_out <= hsync_nxt;
    	end
    	
    	defparam draw_rect_char_game_over.FONT_RECT_WIDTH = 264;
    	defparam draw_rect_char_game_over.FONT_RECT_HEIGHT = 48;
    	defparam draw_rect_char_game_over.FONT_BACKGROUND = 1;
	    defparam draw_rect_char_game_over.FONT_START_X = 380;
	    defparam draw_rect_char_game_over.FONT_START_Y = 360;
	    defparam draw_rect_char_game_over.FONT_BACKGROUND_COLOR = 12'h0_0_0;


	    wire [11:0] rgb_in_delayed;

	    defparam delay_rgb_in.WIDTH = 12;
	    defparam delay_rgb_in.CLK_DEL = 4;

	    delay delay_rgb_in (
	        .clk(clk),
	        .din(rgb_in),
	        .dout(rgb_in_delayed),
	        .rst(rst)

	     );

    	
    	
    	
    	
    	
    	wire [7:0] char_number, char_code;
    	draw_rect_char draw_rect_char_game_over (
         .clk(clk),
         .hsync_in(hsync_in),
         .vsync_in(vsync_in),
         .vcount_in(vcount),
         .hcount_in(hcount),
         .rgb_in(rgb_in),
         .hsync_out(hsync_nxt),
         .vsync_out(vsync_nxt),
         .vcount_out(vcount_nxt),
       	 .hcount_out(hcount_nxt),
         .rgb_out(rgb_rect),
         .rst(rst),
         .char_xy_w(char_number),
         .addr_x_w(char_code)
        );
    char_rom_game_over char_rom_game_over(
    		.clk(clk),
		    .char_xy(char_number),
		    .char_code(char_code)
		    );
    		
endmodule
