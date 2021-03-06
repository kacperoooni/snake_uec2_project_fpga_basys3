`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.09.2020 00:53:13
// Design Name: 
// Module Name: keyboard_driver
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


module keyboard_driver_moving(
		input wire [7:0] word_in,
		input wire clk, rst,
		output reg [7:0] key
    );
    
    localparam
    INIT = 4'd0,
    WAIT_FOR_KEY = 4'd1,
    LATCH_KEY = 4'd2;
    
    localparam
    UP = 8'h38,
    DOWN = 8'h32,
    LEFT = 8'h34,
    RIGHT = 8'h36,
    UP_RIGHT = 8'h39,
    UP_LEFT = 8'h37,
    DOWN_RIGHT = 8'h33,
    DOWN_LEFT = 8'h31,
    MIDDLE = 8'h35;
    
    
    
    reg [3:0] state, state_nxt;
    reg [7:0] key_nxt;
    
    always@(*)
    	begin
    		state_nxt = INIT;
    		key_nxt = key;
    		case(state)
	    		INIT:
	    			begin
	    				state_nxt = WAIT_FOR_KEY;
	    				key_nxt = LEFT;
	    			end	
	    		WAIT_FOR_KEY:
	    			begin
	    				state_nxt = WAIT_FOR_KEY;
	    				if(word_in != key)
	    					begin
	    						case(word_in)
	    							LEFT:
	    								begin 
		    								if(key != RIGHT)	
		    									state_nxt = LATCH_KEY;
	    								end	
	    							RIGHT:
	    								begin 
		    								if(key != LEFT)	
		    									state_nxt = LATCH_KEY;
	    								end	
	    							UP:
	    								begin 
		    								if(key != DOWN)	
		    									state_nxt = LATCH_KEY;
	    								end	
	    							DOWN:
	    								begin 
		    								if(key != UP)	
		    									state_nxt = LATCH_KEY;
	    								end	
	    							UP_LEFT:
	    								begin 
		    								if(key != DOWN_RIGHT)	
		    									state_nxt = LATCH_KEY;
	    								end	
	    							UP_RIGHT:
	    								begin 
		    								if(key != DOWN_LEFT)	
		    									state_nxt = LATCH_KEY;
	    								end	
	    							DOWN_LEFT:
	    								begin 
		    								if(key != UP_RIGHT)	
		    									state_nxt = LATCH_KEY;
	    								end	
	    							DOWN_RIGHT:
	    								begin 
		    								if(key != UP_LEFT)	
		    									state_nxt = LATCH_KEY;
	    								end	
	    							default:
	    								begin end	
	    							endcase	
	    					end		
	    			end
	    		LATCH_KEY:
	    			begin
	    				key_nxt = word_in;
	    				state_nxt = WAIT_FOR_KEY;	
						end    
    		endcase
    		if(rst) state_nxt = INIT;
    		else begin end
			end    
    
    always@(posedge clk)
    	begin
    		state <= state_nxt;
    		key <= key_nxt;
    	end	
    
endmodule
