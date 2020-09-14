`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2020 20:28:12
// Design Name: 
// Module Name: grid_register
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


module grid_register(
    input wire clk, 
    input wire rst,
    input wire game_start,
    input wire [15:0] vcount,
    input wire [15:0] hcount,
    output reg [15:0] vcount_out,
    output reg [15:0] hcount_out,
    
    input wire [11:0] snake_color,
    
    input wire hsync_in,vsync_in,
    output reg hsync_out,vsync_out,
    
    input wire [31:0] rect_read_in, //Xpos,Ypox
    input wire [35:0] rect_write, //Xpos,Ypos,Function
    output reg [3:0] rect_read_out, //Function
    
    input wire [11:0] rgb_in,
    output reg [11:0] rgb_out
    );
    
    
    localparam 
    GRID_SIZE_X = 32,
    GRID_SIZE_Y = 24,
    RECT_SIZE_X = 32,
    RECT_SIZE_Y = 32,
    NULL = 4'b0000,
    SNAKE = 4'b0001,
    ROCK = 4'b0010,
    SNACK = 4'b0100;

    
    reg [3:0] grid_register [768:1];
    reg [3:0] grid_register_nxt [768:1];
    // null - null
    // bit 0 - snake
    // bit 1 - rock
    // bit 2 - snack
    wire [15:0] rect_write_x, rect_write_y, rect_read_x, rect_read_y;
    wire [3:0] rect_write_function;
    
    assign {rect_write_x,rect_write_y,rect_write_function} = rect_write;
    assign {rect_read_x, rect_read_y} = rect_read_in;
    
 
  reg [15:0] current_painted_rect;
  reg [11:0] rgb_nxt;

 
    localparam
    		INTRO = 0,
        INIT = 1,  
        READnWRITE = 2,
        RESET = 3,
        ARENA_GENERATOR = 4;
        
    reg [3:0] state;
    reg [3:0] state_nxt;
    reg [15:0] register_reseter_comb, register_reseter_seq;
    
    
    
    reg [15:0] comb_iterator, comb_iterator_2, seq_iterator_nxt, seq_iterator;
    always@(*)
        begin
        rgb_nxt = rgb_in;
        state_nxt = INTRO;
        rect_read_out = 0;
    			for (comb_iterator = 1; comb_iterator < 769; comb_iterator = comb_iterator +1) 
    				grid_register_nxt[comb_iterator] = grid_register[comb_iterator];	
        		case(state)
        			INTRO:
        					begin
	        					if(game_start == 1) state_nxt = INIT;
	        					else state_nxt = INTRO;	
	        					for(comb_iterator = 1; comb_iterator <= 768; comb_iterator = comb_iterator + 1) 
												begin
													grid_register_nxt[comb_iterator] = NULL;  //GRID RESET
												end
												//S - letter
										grid_register_nxt[5*GRID_SIZE_X+4] = SNAKE;
										grid_register_nxt[5*GRID_SIZE_X+5] = SNAKE;
										grid_register_nxt[5*GRID_SIZE_X+6] = SNAKE;
										grid_register_nxt[5*GRID_SIZE_X+7] = SNAKE;
										grid_register_nxt[6*GRID_SIZE_X+4] = SNAKE;
										grid_register_nxt[7*GRID_SIZE_X+4] = SNAKE;
										grid_register_nxt[8*GRID_SIZE_X+4] = SNAKE;
										grid_register_nxt[8*GRID_SIZE_X+5] = SNAKE;
										grid_register_nxt[8*GRID_SIZE_X+6] = SNAKE;
										grid_register_nxt[8*GRID_SIZE_X+7] = SNAKE;
										grid_register_nxt[9*GRID_SIZE_X+7] = SNAKE;
										grid_register_nxt[10*GRID_SIZE_X+7] = SNAKE;
										grid_register_nxt[11*GRID_SIZE_X+7] = SNAKE;
										grid_register_nxt[11*GRID_SIZE_X+6] = SNAKE;
										grid_register_nxt[11*GRID_SIZE_X+5] = SNAKE;
										grid_register_nxt[11*GRID_SIZE_X+4] = SNAKE;
											//N - letter
										grid_register_nxt[5*GRID_SIZE_X+9] = SNAKE;
										grid_register_nxt[6*GRID_SIZE_X+9] = SNAKE;
										grid_register_nxt[7*GRID_SIZE_X+9] = SNAKE;
										grid_register_nxt[8*GRID_SIZE_X+9] = SNAKE;
										grid_register_nxt[9*GRID_SIZE_X+9] = SNAKE;
										grid_register_nxt[10*GRID_SIZE_X+9] = SNAKE;
										grid_register_nxt[11*GRID_SIZE_X+9] = SNAKE;
										grid_register_nxt[6*GRID_SIZE_X+10] = SNAKE;
										grid_register_nxt[7*GRID_SIZE_X+10] = SNAKE;
										grid_register_nxt[8*GRID_SIZE_X+11] = SNAKE;
										grid_register_nxt[9*GRID_SIZE_X+12] = SNAKE;
										grid_register_nxt[10*GRID_SIZE_X+12] = SNAKE;
										grid_register_nxt[5*GRID_SIZE_X+13] = SNAKE;
										grid_register_nxt[6*GRID_SIZE_X+13] = SNAKE;
										grid_register_nxt[7*GRID_SIZE_X+13] = SNAKE;
										grid_register_nxt[8*GRID_SIZE_X+13] = SNAKE;
										grid_register_nxt[9*GRID_SIZE_X+13] = SNAKE;
										grid_register_nxt[10*GRID_SIZE_X+13] = SNAKE;
										grid_register_nxt[11*GRID_SIZE_X+13] = SNAKE;
										
										//A - letter
										grid_register_nxt[5*GRID_SIZE_X+16] = SNAKE;
										grid_register_nxt[5*GRID_SIZE_X+17] = SNAKE;
										grid_register_nxt[6*GRID_SIZE_X+15] = SNAKE;
										grid_register_nxt[7*GRID_SIZE_X+15] = SNAKE;
										grid_register_nxt[8*GRID_SIZE_X+15] = SNAKE;
										grid_register_nxt[9*GRID_SIZE_X+15] = SNAKE;
										grid_register_nxt[10*GRID_SIZE_X+15] = SNAKE;
										grid_register_nxt[11*GRID_SIZE_X+15] = SNAKE;
										grid_register_nxt[6*GRID_SIZE_X+18] = SNAKE;
										grid_register_nxt[7*GRID_SIZE_X+18] = SNAKE;
										grid_register_nxt[8*GRID_SIZE_X+18] = SNAKE;
										grid_register_nxt[9*GRID_SIZE_X+18] = SNAKE;
										grid_register_nxt[10*GRID_SIZE_X+18] = SNAKE;
										grid_register_nxt[11*GRID_SIZE_X+18] = SNAKE;
										grid_register_nxt[9*GRID_SIZE_X+16] = SNAKE;
										grid_register_nxt[9*GRID_SIZE_X+17] = SNAKE;
										
										//K - letter
										grid_register_nxt[5*GRID_SIZE_X+20] = SNAKE;
										grid_register_nxt[6*GRID_SIZE_X+20] = SNAKE;
										grid_register_nxt[7*GRID_SIZE_X+20] = SNAKE;
										grid_register_nxt[8*GRID_SIZE_X+20] = SNAKE;
										grid_register_nxt[9*GRID_SIZE_X+20] = SNAKE;
										grid_register_nxt[10*GRID_SIZE_X+20] = SNAKE;
										grid_register_nxt[11*GRID_SIZE_X+20] = SNAKE;
										grid_register_nxt[8*GRID_SIZE_X+21] = SNAKE;
										grid_register_nxt[7*GRID_SIZE_X+22] = SNAKE;
										grid_register_nxt[6*GRID_SIZE_X+23] = SNAKE;
										grid_register_nxt[5*GRID_SIZE_X+24] = SNAKE;
										grid_register_nxt[9*GRID_SIZE_X+22] = SNAKE;
										grid_register_nxt[10*GRID_SIZE_X+23] = SNAKE;
										grid_register_nxt[11*GRID_SIZE_X+24] = SNAKE;
										
										//E - letter
										
									  grid_register_nxt[5*GRID_SIZE_X+26] = SNAKE;
										grid_register_nxt[6*GRID_SIZE_X+26] = SNAKE;
										grid_register_nxt[7*GRID_SIZE_X+26] = SNAKE;
										grid_register_nxt[8*GRID_SIZE_X+26] = SNAKE;
										grid_register_nxt[9*GRID_SIZE_X+26] = SNAKE;
										grid_register_nxt[10*GRID_SIZE_X+26] = SNAKE;
										grid_register_nxt[11*GRID_SIZE_X+26] = SNAKE;
									  grid_register_nxt[5*GRID_SIZE_X+27] = SNAKE;
									  grid_register_nxt[5*GRID_SIZE_X+28] = SNAKE;
									  grid_register_nxt[5*GRID_SIZE_X+29] = SNAKE;
									  grid_register_nxt[8*GRID_SIZE_X+27] = SNAKE;
									  grid_register_nxt[8*GRID_SIZE_X+28] = SNAKE;
									  grid_register_nxt[8*GRID_SIZE_X+29] = SNAKE;
									  grid_register_nxt[11*GRID_SIZE_X+27] = SNAKE;
									  grid_register_nxt[11*GRID_SIZE_X+28] = SNAKE;
									  grid_register_nxt[11*GRID_SIZE_X+29] = SNAKE;
									end  
           		 INIT:
              		begin
              			state_nxt = ARENA_GENERATOR;
                		for(comb_iterator = 1; comb_iterator <= 768; comb_iterator = comb_iterator + 1) 
											begin
												grid_register_nxt[comb_iterator] = NULL;  //GRID RESET
											end
									end			
							ARENA_GENERATOR:
									begin
										state_nxt = READnWRITE;				
												grid_register_nxt[2*GRID_SIZE_X+3] = SNACK;
										for(comb_iterator = 1; comb_iterator <= 32; comb_iterator = comb_iterator + 1) 
											begin
												grid_register_nxt[comb_iterator] = ROCK;
												grid_register_nxt[23*GRID_SIZE_X+comb_iterator] = ROCK;
											end			
										for(comb_iterator = 1; comb_iterator <= 24; comb_iterator = comb_iterator + 1) 
											begin
												grid_register_nxt[1+comb_iterator*32] = ROCK;
												grid_register_nxt[32+comb_iterator*32] = ROCK;
											end	
													
             			end			  
            		READnWRITE:
         			    begin
             				if (rect_write_y >= 0 && rect_write_y <= 32 && rect_write_x >= 0 && rect_write_x <= 32) grid_register_nxt[rect_write_y*GRID_SIZE_X+rect_write_x] = rect_write_function;
               		  if (rect_read_y >= 0 && rect_read_y <= 32 && rect_read_x >= 0 && rect_read_x <= 32) 	rect_read_out = grid_register[rect_read_y*GRID_SIZE_X+rect_read_x];
              			if (rst) state_nxt = RESET;
              		  else state_nxt = READnWRITE;                  
               		end
            		RESET:
               	  begin        
                    state_nxt = INTRO;
                  end
        		endcase        
            if(vcount >= 0 && vcount <= 768 && hcount >= 0 && hcount <= 1024)
             begin
               current_painted_rect = vcount/RECT_SIZE_Y*RECT_SIZE_X+hcount/RECT_SIZE_X+1;
               case(grid_register[current_painted_rect])
                  NULL:
                    begin
                      rgb_nxt = rgb_in;
                    end
                  SNAKE:
                    begin
                      rgb_nxt = snake_color;
          //							rgb_nxt = 12'hC_2_B;
                    end
                  ROCK:
                    begin
                      rgb_nxt = 12'h2_2_2;
                    end
                  SNACK:
                     begin
                      rgb_nxt = 12'hf_0_0;
                     end 
                  default:
                     begin  
                      rgb_nxt = rgb_in;
                     end           
               endcase
             end
        end    
    
    always@(posedge clk)
        begin
            state <= state_nxt;
            rgb_out <= rgb_nxt;
            hsync_out <= hsync_in;
            vsync_out <= vsync_in;
            vcount_out <= vcount;
            hcount_out <= hcount;
	//		seq_iterator <= seq_iterator_nxt;
	//		grid_register[seq_iterator] <= grid_register_nxt[seq_iterator];
			
			
         end   
         
    genvar X1;
	
	generate
		begin
			for (X1 = 1; X1 <= 768; X1 = X1 + 1)
				always@(posedge clk) grid_register[X1] <= grid_register_nxt[X1];
		end
	endgenerate	

        
endmodule
