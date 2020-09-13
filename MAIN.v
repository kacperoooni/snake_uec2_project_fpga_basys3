`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2020 15:55:41
// Design Name: 
// Module Name: MAIN
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


module MAIN(
    input wire clk,
    input wire rst,
    output wire [3:0] r,
    output wire [3:0] g,
    output wire [3:0] b,
    output wire vsync,
    output wire hsync,
	//	input wire [3:0] key,
		input wire rx,
		output wire tx,
		//debug
	input wire [4:0] sw,
	output wire [6:0] sseg,
	output wire [3:0] an,
	output wire [7:0] led
    );
    wire clk_100Mhz, clk_65Mhz;
    
    
    clk_wiz_0 clk_wiz_0 (
      .clk_in1(clk),
      .clk_100Mhz(clk_100Mhz),
      .clk_65Mhz(clk_65Mhz)
    //  .reset(rst)
      );

      wire [15:0] vcount_wire, hcount_wire;
      wire [11:0] rgb_out_wire;
      wire vblnk_wire, hblnk_wire, hsync_wire, vsync_wire;
      
       
    

    VGA_timing_controller VGA_timing_controller (
      .vcount(vcount_wire),
      .hcount(hcount_wire),
      .rst(rst),
      .hsync(hsync_wire),
      .vsync(vsync_wire),
      .vblnk(vblnk_wire),
      .hblnk(hblnk_wire),
      .clk(clk_65Mhz)
     );
     wire [15:0] vcount_wire_RGB_to_grid, hcount_wire_RGB_to_grid;
     wire [11:0] rgb_RGB_to_grid;
     wire hsync_rgb_controller_grid_register,vsync_rgb_controller_grid_register;
     
    VGA_rgb_controller VGA_rgb_controller (
       .clk(clk_65Mhz),
       .hcount_in(hcount_wire),
       .hsync_in(hsync_wire),
       .vsync_in(vsync_wire),
       .hsync_out(hsync_rgb_controller_grid_register),
       .vsync_out(vsync_rgb_controller_grid_register),
       .hblnk_in(hblnk_wire),
       .vcount_in(vcount_wire),
       .vblnk_in(vblnk_wire),
       .rgb_out(rgb_RGB_to_grid),
       .vcount_out(vcount_wire_RGB_to_grid),
       .hcount_out(hcount_wire_RGB_to_grid),
	   .rst(rst)
      );
    
    wire [31:0] rect_read_wire;
		wire [3:0] rect_read_function_wire;
    wire [3:0] rect_write_function;
		wire [31:0] rect_read;
    wire [35:0] rect_write_wire;
    wire hsync_grid_register_grid_edges,vsync_grid_register_grid_edges;
    wire [11:0] rgb_grid_register_grid_edges;
    wire [15:0] vcount_grid_register_grid_edges,hcount_grid_register_grid_edges;
    wire [7:0] keydata_key_debouncer_to_keyboard_driver, key;
    wire turbo_button;
    
    wire vsync_grid_edge_rect_char, hsync_grid_edge_rect_char;
    wire [15:0] vcount_grid_edge_rect_char, hcount_grid_edge_rect_char;
    wire [11:0] rgb_grid_edge_rect_char;
    wire [7:0] char_number_score, char_code_score;
		wire [15:0] score;
		wire [7:0] r_data, r_data_debug;
		wire rx_empty;
		wire [15:0] vcount_score_to_menu, hcount_score_to_menu;
		wire [11:0] rgb_score_to_menu;
		wire hsync_score_to_menu,vsync_score_to_menu;
		wire menu_interrupt_menu_to_rect;
		wire [15:0] iterator_debug;
    
    grid_register grid_register (
       .clk(clk_65Mhz),
       .rgb_out(rgb_grid_register_grid_edges),
       .vcount(vcount_wire_RGB_to_grid),
       .hcount(hcount_wire_RGB_to_grid),
       .hcount_out(hcount_grid_register_grid_edges),
       .vcount_out(vcount_grid_register_grid_edges),
       .rgb_in(rgb_RGB_to_grid),
       .rst(rst),
       .rect_read_in(rect_read),
       .rect_write(rect_write_wire),
       .rect_read_out(rect_read_function_wire),
       .hsync_in(hsync_rgb_controller_grid_register),
       .vsync_in(vsync_rgb_controller_grid_register),
       .hsync_out(hsync_grid_register_grid_edges),
       .vsync_out(vsync_grid_register_grid_edges)
       );
    
    rect_controller rect_controller (
       .clk(clk_65Mhz),
	     .key(key),
       .rect_write(rect_write_wire),
       .rect_read_out(rect_read),
	     .rst(rst),
	     .rect_read_in(rect_read_function_wire),
	     .turbo_button(turbo_button),
	     .score_out(score),
	   //debug
	  //   .keyboard_debug(word_uart_to_keyboard),
	     .debug_keys(sw),
	     .sseg(sseg),
	     .an(an),
	     .r_data(r_data_debug),
	     .menu_interrupt(menu_interrupt_menu_to_rect),
	     .iterator_debug(iterator_debug)
       );  
       
       
    grid_edges grid_edges (
    .vcount_in(vcount_grid_register_grid_edges),
    .hcount_in(hcount_grid_register_grid_edges),
    .vcount_out(vcount_grid_edge_rect_char),
    .hcount_out(hcount_grid_edge_rect_char),
    .rgb_in(rgb_grid_register_grid_edges),
    .rgb_out(rgb_grid_edge_rect_char),
    .clk(clk_65Mhz),
    .hsync_in(hsync_grid_register_grid_edges),
    .vsync_in(vsync_grid_register_grid_edges),
    .vsync_out(vsync_grid_edge_rect_char),
    .hsync_out(hsync_grid_edge_rect_char)	
    );
    

   
    //baud 9600
    uart uart (
    .clk(clk_65Mhz),
    .reset(rst),
    .rx(rx),
    .tx(tx),
    .led(led),
    .r_data(r_data),
    .rx_empty(rx_empty)
    );
    
    keyboard_driver_moving keyboard_driver_moving (
	    .clk(clk_65Mhz),
	    .rst(rst),
	  	.word_in(keydata_key_debouncer_to_keyboard_driver),
	    .key(key),
	    .turbo_button(turbo_button)
    );   
       
     
  draw_rect_char draw_rect_char (
   
         .clk(clk_65Mhz),
    
         .hsync_in(hsync_grid_edge_rect_char),
       //  .vblnk_in(vblnk_background_rect_char),
       //  .hblnk_in(hblnk_background_rect_char),
         .vsync_in(vsync_grid_edge_rect_char),
         .vcount_in(vcount_grid_edge_rect_char),
         .hcount_in(hcount_grid_edge_rect_char),
         .rgb_in(rgb_grid_edge_rect_char),
         .hsync_out(hsync_score_to_menu),
     //    .vblnk_out(vblnk_rect_char_rect),
     //    .hblnk_out(hblnk_rect_char_rect),
         .vsync_out(vsync_score_to_menu),
         .vcount_out(vcount_score_to_menu),
         .hcount_out(hcount_score_to_menu),
         .rgb_out(rgb_score_to_menu),
         .rst(rst),
         .char_xy_w(char_number_score),
         .addr_x_w(char_code_score)
        );   
  
  char_rom char_rom (
		    .clk(clk_65Mhz),
		    .char_xy(char_number_score),
		    .char_code(char_code_score),
		    .score_in(score)
    );
    
  
  key_debouncer key_debouncer (
  			.clk(clk_65Mhz),
  			.r_data(r_data),
  			.rx_empty(rx_empty),
  			.r_data_debug(r_data_debug),
  			.key_data(keydata_key_debouncer_to_keyboard_driver)
  );
               
  menu_display menu_display (
  			.clk(clk_65Mhz),
  			.rst(rst),
  			.key(keydata_key_debouncer_to_keyboard_driver),
  			.hcount(hcount_grid_edge_rect_char),
  			.vcount(vcount_grid_edge_rect_char),
  			.hsync_in(hsync_score_to_menu),
  			.vsync_in(vsync_score_to_menu),
  			.rgb_in(rgb_score_to_menu),
  			.rgb_out({r,g,b}),
  			.vsync_out(vsync),
  			.hsync_out(hsync),
  			.menu_interrupt_out(menu_interrupt_menu_to_rect),
  			.iterator_debug(iterator_debug)	
  );             
endmodule
