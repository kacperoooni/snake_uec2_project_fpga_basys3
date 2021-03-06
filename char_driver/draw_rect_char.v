`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.04.2020 14:43:09
// Design Name: 
// Module Name: draw_rect_char
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:MODU� ZAIMPORTOWANY Z MOJEGO CWICZENIA NR 5 - UEC2
// 
//////////////////////////////////////////////////////////////////////////////////


module draw_rect_char
		#( parameter
				FONT_RECT_HEIGHT = 256, //podaj liczbe podzielna przez 16
				FONT_RECT_WIDTH = 128, // podaj liczbe podzielna przez 8
				FONT_START_X = 850,
				FONT_START_Y = 30,
				FONT_COLOR = 12'hf_f_f,
        FONT_BACKGROUND = 0,
        FONT_BACKGROUND_COLOR = 12'h0_0_0
    )
    (
    input wire clk,

    input wire hsync_in,
  //  input wire vblnk_in,
  //  input wire hblnk_in,
    input wire vsync_in,
    input wire [15:0] vcount_in,
    input wire [15:0] hcount_in,
    input wire [11:0] rgb_in,
    input wire rst,
		output reg [7:0] char_xy_w,
    input wire [7:0] addr_x_w,
    
    output wire hsync_out,
  //  output wire vblnk_out,
  // output wire hblnk_out,
    output wire vsync_out,
    output wire [15:0] vcount_out,
    output wire [15:0] hcount_out,
    
    output reg [11:0] rgb_out
    
    );
    
    localparam FONT_HEIGHT = 16,
               FONT_WIDTH = 8,
           //    FONT_RECT_HEIGHT = 256, //podaj liczbe podzielna przez 16
           //    FONT_RECT_WIDTH = 128, // podaj liczbe podzielna przez 8
           //    FONT_START_X = 850,
           //    FONT_START_Y = 30,
               ASCI_ADDR_START = 48;
           //    FONT_COLOR = 12'hf_f_f;
             // FONT_BACKGROUND = rgb_in;   
    //STATES
               localparam  INIT = 0,
                           NOT_IN_RECT = 1,
                           BIT_PAINTING = 2,
                           EXIT_RECT = 3;
                                   
    
    
    reg [4:0] font_iterator_x; //licznik bit�w z font_rom'u
    reg [4:0] font_iterator_x_nxt;
    
    reg [11:0]rgb_nxt; 
    
    reg [9:0] char_counter; //licznik cyfr
    reg [9:0] char_counter_nxt;
    
    reg [31:0] line_counter; // licznik linii
    reg [31:0] line_counter_nxt;
    
    reg [31:0] offset; // offset licznika cyfr
    reg [31:0] offset_nxt;
    
   //wire bit_test;
   
    //assign bit_test = char_pixels[font_iterator_x]; //test poprawnosci odczytanych bit�w z font chara na potrzeby symulacji
    
    //assign addr_nxt = {(hcount_in[9:3] + ASCI_ADDR_START),vcount_in[3:0]};
    
    
 
    
                   
    wire [11:0] rgb_in_del;
    
    reg [3:0] state_nxt;
    reg [3:0] state;
    
    wire [10:0] addr;
		wire [0:7] char_pixels;
    
    
                
    
    
    
    
    always@(*)
	    begin
		    rgb_nxt = rgb_out;
		    line_counter_nxt = line_counter;
		    offset_nxt = offset;
		    char_counter_nxt = char_counter;
		    font_iterator_x_nxt = font_iterator_x;
		    state_nxt = INIT;
		    case(state)
		    
		    INIT:
		        begin
			        line_counter_nxt = 0;
			        offset_nxt = 0;
			        char_counter_nxt = 0;
			        rgb_nxt = rgb_in_del;
			        font_iterator_x_nxt = 0;
			        line_counter_nxt = 0;
			        state_nxt = NOT_IN_RECT;
		        end
		    NOT_IN_RECT:
		        begin
			        char_counter_nxt = 0;
			        rgb_nxt = rgb_in_del;
			        font_iterator_x_nxt = 0;
			        state_nxt = ((hcount_in >= FONT_START_X+2) && (hcount_in <= FONT_START_X + FONT_RECT_WIDTH) && 
			        (vcount_in >= FONT_START_Y) && (vcount_in <= FONT_START_Y + FONT_RECT_HEIGHT)) ? BIT_PAINTING : NOT_IN_RECT;
		        end
		    BIT_PAINTING:
		        begin
			        state_nxt = BIT_PAINTING;
			        font_iterator_x_nxt = font_iterator_x + 1;
			        if(FONT_BACKGROUND == 1) rgb_nxt = (char_pixels[font_iterator_x] == 1) ? FONT_COLOR : FONT_BACKGROUND_COLOR;
			        else rgb_nxt = (char_pixels[font_iterator_x] == 1) ? FONT_COLOR : rgb_in;
			        if(font_iterator_x == 7) 
			            begin
			            font_iterator_x_nxt = 0;
			            end
			        else begin end
			        if(font_iterator_x == 4)
			            begin
			            char_counter_nxt = char_counter + 1;
			            end
			        else begin end    
			        if(hcount_in == FONT_START_X + FONT_RECT_WIDTH+1)
			            begin
			            line_counter_nxt = line_counter + 1;
			            state_nxt = NOT_IN_RECT;
			            end
			        else begin end
			        if(line_counter == 16)
			            begin
			            offset_nxt = offset + 1;
			            line_counter_nxt = 0;
			            end
			        else begin end
			        if((vcount_in == FONT_START_Y + FONT_RECT_HEIGHT) && (hcount_in == FONT_START_X + FONT_RECT_WIDTH))
			            begin
			            state_nxt = INIT;
			            end
			            else begin end  
			      end   
		   	endcase
	    end
    
    
    
    wire [10:0] addr_y ;
    wire [3:0] addry_test;
    assign addry_test = addr_y[3:0];
    assign addr_y = (vcount_in-FONT_START_Y);
    
    assign addr = {addr_x_w,addr_y[3:0]};
    
    always@(posedge clk or posedge rst)
	    begin
		    rgb_out <= rgb_nxt;
		    line_counter <= line_counter_nxt;
		    offset <= offset_nxt;
		    char_xy_w <= ((char_counter_nxt+(FONT_RECT_WIDTH/8)*offset));
		    char_counter <= char_counter_nxt;
		    font_iterator_x <= font_iterator_x_nxt;
		    state <= state_nxt; 
		    if (rst == 1)
			    begin
				    rgb_out <= 0;
				    line_counter <= 0;
				    offset <= 0;
				    char_xy_w <= 0;
				    char_counter <= 0;
				    font_iterator_x <= 0;
				    state <= INIT;
			    end
	    else begin end
    end
    
    
    
    font_rom font_rom (
         .clk(clk),
         .addr(addr),
         .char_line_pixels(char_pixels)
  );
    
    
    
    
    
    
    
    
    
    
    //DELAY 
    
     
    
    
    
    
    localparam CLK_DELAY = 4;
    
    delay delay_hsync (
        .clk(clk),
        .din(hsync_in),
        .dout(hsync_out),
        .rst(rst)
        
     );
    defparam delay_hsync.WIDTH = 1;
    defparam delay_hsync.CLK_DEL = CLK_DELAY;
    
    delay delay_vsync (
        .clk(clk),
        .din(vsync_in),
        .dout(vsync_out),
        .rst(rst)
     );
     defparam delay_vsync.WIDTH = 1;
     defparam delay_vsync.CLK_DEL = CLK_DELAY;
 /*        
     delay delay_vblnk (
         .clk(clk),
         .din(vblnk_in),
         .dout(vblnk_out),
         .rst(rst)
     );   
    defparam delay_vblnk.WIDTH = 1;
    defparam delay_vblnk.CLK_DEL = CLK_DELAY;
           
    delay delay_hblnk (
         .clk(clk),
         .din(hblnk_in),
         .dout(hblnk_out),
         .rst(rst)
          );         
    defparam delay_hblnk.WIDTH = 1;
    defparam delay_hblnk.CLK_DEL = CLK_DELAY;
  */  
    delay delay_vcount (
         .clk(clk),
         .din(vcount_in),
         .dout(vcount_out),
         .rst(rst)
          );
     defparam delay_vcount.WIDTH = 16;
     defparam delay_vcount.CLK_DEL = CLK_DELAY; 
          
   delay delay_hcount (
         .clk(clk),
         .din(hcount_in),
         .dout(hcount_out),
         .rst(rst)
          ); 
      defparam delay_hcount.WIDTH = 16;
      defparam delay_hcount.CLK_DEL = CLK_DELAY;
  
   delay delay_rgb (
         .clk(clk),
         .din(rgb_in),
         .dout(rgb_in_del),
         .rst(rst)
         ); 
       defparam delay_rgb.WIDTH = 12;
       defparam delay_rgb.CLK_DEL = CLK_DELAY-1;                                       
    
endmodule
