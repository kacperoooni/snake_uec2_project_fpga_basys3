`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 13.09.2020 20:13:07
// Design Name:
// Module Name: menu_display
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


module menu_display(
		input wire clk,
		input wire rst,
		input wire [7:0] key,
		input wire [15:0] vcount, hcount,
		output reg [15:0] vcount_out, hcount_out,
		input wire vsync_in,hsync_in,
		output reg hsync_out,vsync_out,
		input wire [11:0] rgb_in,
		output reg [11:0] rgb_out,
		output reg menu_interrupt_out,
		output wire [15:0] iterator_debug
    );
		assign iterator_debug = iterator;
    wire [7:0] char_number_score, char_code_score;
    reg menu_interrupt_nxt;
    wire [11:0] rgb_rect;
    reg [3:0] state,state_nxt;
    reg [11:0] rgb_nxt;
    reg [15:0] iterator, iterator_nxt;
    localparam
    INIT = 0,
    WAIT_FOR_KEY = 2,
    MENU_OPEN = 3;
    
    localparam
    KEY_1 = 8'h31,
    KEY_2 = 8'h32,
    KEY_3 = 8'h33;

    always@(*)
    	begin
	    	state_nxt = INIT;
		   	if(iterator == 4) iterator_nxt = 4;
		  	else iterator_nxt = iterator + 1;

	    	rgb_nxt = rgb_in_delayed;
	    	menu_interrupt_nxt = menu_interrupt_out;
	    	case(state)
	    		INIT:
	    			begin
	    				state_nxt = WAIT_FOR_KEY;
	    				menu_interrupt_nxt = 0;
	    				iterator_nxt = 0;
	    			end
	    		WAIT_FOR_KEY:
	    			begin
	    				if((key == 8'h1b) && (iterator == 4))
	    					begin
	    					 state_nxt = MENU_OPEN;
	    					 iterator_nxt = 0;
	    					end 
	    			  else state_nxt = WAIT_FOR_KEY;
	    				menu_interrupt_nxt = 0;
	    			end
	    		MENU_OPEN:
	    			begin
	    				if((key == 8'h1b) && (iterator == 4))	
	    				begin
	    					 state_nxt = WAIT_FOR_KEY;
	    					 iterator_nxt = 0;
	    					end 
	    				else state_nxt = MENU_OPEN;
	    				if(iterator == 4)
	    					begin
	    						case(key)
	    							KEY_1:begin end
	    							KEY_2:begin end
	    							KEY_3:begin end
	    						endcase
	    						iterator_nxt = 0;
	    					end		
	    				rgb_nxt = rgb_rect;
	    				menu_interrupt_nxt = 1;
	    			end
	    	endcase
    	end

   wire [15:0] vcount_nxt, hcount_nxt;
   wire vsync_nxt, hsync_nxt;

   	always@(posedge clk)
   		begin
   			rgb_out <= rgb_nxt;
   			vcount_out <= vcount_nxt;
   			hcount_out <= vcount_nxt;
   			vsync_out <= vsync_nxt;
    		hsync_out <= hsync_nxt;
    		state <= state_nxt;
    		menu_interrupt_out <= menu_interrupt_nxt;
    		iterator <= iterator_nxt;
    	end

    defparam draw_rect_char_menu.FONT_BACKGROUND = 1;
    defparam draw_rect_char_menu.FONT_START_X = 448;
    defparam draw_rect_char_menu.FONT_START_Y = 256;
    defparam draw_rect_char_menu.FONT_BACKGROUND_COLOR = 12'h7_7_7;


    wire [11:0] rgb_in_delayed;

    defparam delay_rgb_in.WIDTH = 12;
    defparam delay_rgb_in.CLK_DEL = 3;

    delay delay_rgb_in (
        .clk(clk),
        .din(rgb_in),
        .dout(rgb_in_delayed)

     );



    draw_rect_char draw_rect_char_menu (
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
         .char_xy_w(char_number_score),
         .addr_x_w(char_code_score)
        );
    char_rom_menu char_rom_menu(
    		.clk(clk),
		    .char_xy(char_number_score),
		    .char_code(char_code_score)
		    );
endmodule
