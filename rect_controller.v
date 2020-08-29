`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.08.2020 23:42:23
// Design Name: 
// Module Name: rect_controller
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


module rect_controller(
    output reg [31:0] rect_read_out,
    output reg [35:0] rect_write,
    input wire [3:0] rect_read_in,
    input wire clk,
		input wire [3:0] key,
		input wire rst,
		
		
	
	//DEBUG
		output reg [3:0] an,  // enable 1-out-of-4 asserted low
    output reg [6:0] sseg, // led segments
		input wire [4:0] debug_keys
	
	
    );
   localparam 
      GRID_SIZE_X = 32,
      GRID_SIZE_Y = 24,
      RECT_SIZE_X = (1024/GRID_SIZE_X),
      RECT_SIZE_Y = (768/GRID_SIZE_Y),
      NULL = 4'b0000,
      SNAKE = 4'b0001,
      ROCK = 4'b0010,
      SNACK = 4'b0100;
   
   localparam //states
	INIT = 0,
	SNAKE_MOVING = 1,
	SNAKE_GROW = 2,
	RESET = 3,
	GAME_OVER = 4,
	SNAKE_DRAWING = 5,
	COLLISION_CHECK = 6;
   
   localparam //states
	UP = 4'b0010,
	DOWN = 4'b0001,
	LEFT = 4'b0100,
	RIGHT = 4'b1000;
	
	
	
   
   
   reg [15:0] rect_read_x_nxt, rect_read_y_nxt;
   reg [3:0]  state = INIT;
   reg [3:0]  state_nxt = INIT;
   reg [35:0] rect_write_nxt;
   reg [31:0] snake_register [31:0];
   reg [31:0] snake_register_nxt [31:0];
   
   reg [31:0] i; //intertor for smth
   reg [4:0] snake_writer_iterator, snake_writer_iterator_nxt; //interator for writing snake rects
   reg [31:0] snake_moving_iterator,snake_moving_iterator_nxt; //interator for moving period of snake
   
   
   reg [15:0] snake_x,snake_y;
  // {snake_x,snake_y} = snake_register[0];
   reg [3:0] key_latch, key_latch_nxt;
   reg [4:0] snake_size, snake_size_nxt;
   reg [31:0] previous_read_rect;
   
   
   
   
   
   
  //{rect_write_x,rect_write_y,rect_write_function} = rect_write;
   always@(*)
     begin
			state_nxt = INIT;
			snake_moving_iterator_nxt = snake_moving_iterator + 1;
			snake_writer_iterator_nxt = snake_writer_iterator;
			snake_size_nxt = snake_size;
			rect_write_nxt = rect_write; //WARNING!! CAN CAUSE UNEXPECTED WRITE TO MEMORY
			rect_read_out = snake_register[0];
			for(i = 0; i <= 31; i=i+1)
				begin
					snake_register_nxt[i] = snake_register[i];
				end
			if(key == 0)
				begin
					key_latch_nxt = key_latch;
				end
			else
				begin
					key_latch_nxt = key;
				end	

			
			case(state)
				INIT:
					begin
						for(i = 0; i <= 31; i=i+1)
							begin
								snake_register_nxt[i] = 0;
							end
						snake_register_nxt[0] = {16'd15,16'd15};	
						snake_register_nxt[1] = {16'd16,16'd15};
						snake_register_nxt[2] = {16'd17,16'd15};
						snake_register_nxt[3] = {16'd18,16'd15};
						snake_size_nxt = 3; // with 0
						snake_writer_iterator_nxt = 0;
						snake_moving_iterator_nxt = 0;
						state_nxt = SNAKE_MOVING;
						key_latch_nxt = LEFT;
					end
					
				SNAKE_MOVING:
					begin
						state_nxt = COLLISION_CHECK;	
						snake_moving_iterator_nxt = 0;
							for(i = 0; i < 31; i=i+1)
								begin
									snake_register_nxt[i+1] = snake_register[i]; //shift snake stack
								end
							case(key_latch)
								UP:
									begin
										snake_register_nxt[0] = {snake_register[0][31:16],snake_register[0][15:0]+16'd1};
									end	
								LEFT:
									begin
										snake_register_nxt[0] = {snake_register[0][31:16]-16'd1,snake_register[0][15:0]};
									end	
								RIGHT:
									begin
										snake_register_nxt[0] = {snake_register[0][31:16]+16'd1,snake_register[0][15:0]};
									end			
								DOWN:
									begin
										snake_register_nxt[0] = {snake_register[0][31:16],snake_register[0][15:0]-16'd1};
									end	
								//TO DO DIAGONALS
							endcase
					end	
						
					SNAKE_DRAWING:
						begin
							if(snake_moving_iterator == 50000000)	state_nxt = SNAKE_MOVING;
							else if(rst) state_nxt = INIT;
							else state_nxt = SNAKE_DRAWING; 	
							
							if(snake_register[snake_writer_iterator] != 0)
								rect_write_nxt = {snake_register[snake_writer_iterator], SNAKE};
						  if(snake_writer_iterator == snake_size+5'd1)
								begin
									rect_write_nxt = {snake_register[snake_writer_iterator], NULL};
									snake_register_nxt[snake_writer_iterator+5'd1] = 0;
								end	
			
							if(snake_writer_iterator == 5'd31) snake_writer_iterator_nxt = 0;
							else snake_writer_iterator_nxt = snake_writer_iterator + 5'd1;
								
								
						end
						
				COLLISION_CHECK:		
						begin
							case(rect_read_in)
								SNAKE:
									state_nxt = GAME_OVER;
								SNACK:
									state_nxt = SNAKE_GROW;
								ROCK:
									state_nxt = GAME_OVER;
								default:
									state_nxt = SNAKE_DRAWING;			
							endcase
						end								
				SNAKE_GROW:
					begin
						snake_size_nxt = snake_size + 5'd1;
						state_nxt = SNAKE_DRAWING;
						snake_writer_iterator_nxt = 0;
					end	
				GAME_OVER:	
					begin
						if(rst) state_nxt = INIT;
						else state_nxt = GAME_OVER;
					end
				//SNACK_GENERATE:		
				//TODO		
			endcase
			
		
			
		end
   			
   always@(posedge clk)
        begin
			snake_writer_iterator <= snake_writer_iterator_nxt;
			snake_moving_iterator <= snake_moving_iterator_nxt;
			snake_size <= snake_size_nxt;
			state <= state_nxt;
			rect_write <= rect_write_nxt;
			key_latch <= key_latch_nxt;	
        end
genvar X;		
	generate
			begin
			for (X = 0; X < 32; X = X+1)		
				begin
					always@(posedge clk)
						begin
							snake_register[X] <= snake_register_nxt[X];
						end	
				end
			end	
	endgenerate	 
	
	
	
     //DEBUG
	wire [3:0] hex3, hex2, hex1, hex0;  // hex digits
    wire [3:0] dp_in;             // 4 decimal points
	wire [31:0] rx;
	
	assign rx = snake_register[debug_keys];
 	assign {hex3, hex2, hex1, hex0} = {rx[23:16],rx[7:0]};


   // constant declaration
   // refreshing rate around 800 Hz (50 MHz/2^16)
   localparam N = 18;
   // internal signal declaration
   reg [N-1:0] q_reg;
   wire [N-1:0] q_next;
   reg [3:0] hex_in;
   reg dp;

   // N-bit counter
   // register
   always @(posedge clk, posedge rst)
      if (rst)
         q_reg <= 0;
      else
         q_reg <= q_next;

   // next-state logic
   assign q_next = q_reg + 1;

   // 2 MSBs of counter to control 4-to-1 multiplexing
   // and to generate active-low enable signal
   always @*
      case (q_reg[N-1:N-2])
         2'b00:
            begin
               an =  4'b1110;
               hex_in = hex0;
               dp = dp_in[0];
            end
         2'b01:
            begin
               an =  4'b1101;
               hex_in = hex1;
               dp = dp_in[1];
            end
         2'b10:
            begin
               an =  4'b1011;
               hex_in = hex2;
               dp = dp_in[2];
            end
         default:
            begin
               an =  4'b0111;
               hex_in = hex3;
               dp = dp_in[3];
            end
       endcase

   // hex to seven-segment led display
   always @*
   begin
      case(hex_in)
         4'h0: sseg[6:0] = 7'b0000001;
         4'h1: sseg[6:0] = 7'b1001111;
         4'h2: sseg[6:0] = 7'b0010010;
         4'h3: sseg[6:0] = 7'b0000110;
         4'h4: sseg[6:0] = 7'b1001100;
         4'h5: sseg[6:0] = 7'b0100100;
         4'h6: sseg[6:0] = 7'b0100000;
         4'h7: sseg[6:0] = 7'b0001111;
         4'h8: sseg[6:0] = 7'b0000000;
         4'h9: sseg[6:0] = 7'b0000100;
         4'ha: sseg[6:0] = 7'b0001000;
         4'hb: sseg[6:0] = 7'b1100000;
         4'hc: sseg[6:0] = 7'b0110001;
         4'hd: sseg[6:0] = 7'b1000010;
         4'he: sseg[6:0] = 7'b0110000;
         default: sseg[6:0] = 7'b0111000;  //4'hf
     endcase
   end


	 
    
    
   
endmodule
