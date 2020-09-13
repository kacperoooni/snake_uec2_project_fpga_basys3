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
output reg [7:0] char_code
    );
    reg [7:0] addr_x;
    
    always @(posedge clk)
    begin
    char_code <= addr_x;
    end
    
    always@(*)
    begin
        case (char_xy)
         		/*	8'h06: addr_x = 8'h4D; //M
              8'h07: addr_x = 8'h45; //E
              8'h08: addr_x = 8'h4E; //N
              8'h09: addr_x = 8'h55; //U
              default: addr_x = 8'h20;					 
              */
           					 8'h00: addr_x = 7'h4c; // L
                     8'h01: addr_x = 7'h69; // i
                     8'h02: addr_x = 7'h74; // t
                     8'h03: addr_x = 7'h77; // w
                     8'h04: addr_x = 7'h6f; // o
                     8'h05: addr_x = 7'h2c; // ,
                     8'h06: addr_x = 7'h20; //      ***************************************
                     8'h07: addr_x = 7'h6f; // o
                     8'h08: addr_x = 7'h6a; // j
                     8'h09: addr_x = 7'h63; // c
                     8'h0a: addr_x = 7'h7a; // z
                     8'h0b: addr_x = 7'h79; // y
                     8'h0c: addr_x = 7'h7a; // z
                     8'h0d: addr_x = 7'h6e; // n
                     8'h0e: addr_x = 7'h6f; // o
                     8'h0f: addr_x = 7'h20; // 
                     8'h10: addr_x = 7'h6d; // m
                     8'h11: addr_x = 7'h6f; // o
                     8'h12: addr_x = 7'h6a; // j
                     8'h13: addr_x = 7'h61; // a
                     8'h14: addr_x = 7'h21; // !
                     8'h15: addr_x = 7'h20; // 
                     8'h16: addr_x = 7'h54; // T
                     8'h17: addr_x = 7'h79; // y
                     8'h18: addr_x = 7'h20; // 
                     8'h19: addr_x = 7'h6a; // j
                     8'h1a: addr_x = 7'h65; // e
                     8'h1b: addr_x = 7'h73; // s
                     8'h1c: addr_x = 7'h74; // t
                     8'h1d: addr_x = 7'h65; // e 
                     8'h1e: addr_x = 7'h73; // s
                     8'h1f: addr_x = 7'h20; //  
                     8'h20: addr_x = 7'h6a; //  j
                     8'h21: addr_x = 7'h61; // a
                     8'h22: addr_x = 7'h6b; // k
                     8'h23: addr_x = 7'h20; // 
                     8'h24: addr_x = 7'h7a; // z
                     8'h25: addr_x = 7'h64; // d
                     8'h26: addr_x = 7'h72; // r
                     8'h27: addr_x = 7'h6f; // o
                     8'h28: addr_x = 7'h77; // w
                     8'h29: addr_x = 7'h69; // i
                     8'h2a: addr_x = 7'h65; // e
                     8'h2b: addr_x = 7'h3b; // ;
                     8'h2c: addr_x = 7'h20; // 
                     8'h2d: addr_x = 7'h49; // I
                     8'h2e: addr_x = 7'h6c; // l
                     8'h2f: addr_x = 7'h65; // e
                     8'h30: addr_x = 7'h43; // C
                     8'h31: addr_x = 7'h69; // i
                     8'h32: addr_x = 7'h65; // e
                     8'h33: addr_x = 7'h20; // 
                     8'h34: addr_x = 7'h74; // t
                     8'h35: addr_x = 7'h72; // r
                     8'h36: addr_x = 7'h7a; // z
                     8'h37: addr_x = 7'h65; // e
                     8'h38: addr_x = 7'h62; // b
                     8'h39: addr_x = 7'h61; // a
                     8'h3a: addr_x = 7'h20; // 
                     8'h3b: addr_x = 7'h63; // c
                     8'h3c: addr_x = 7'h65; // e
                     8'h3d: addr_x = 7'h6e; // n
                     8'h3e: addr_x = 7'h69; // i
                     8'h3f: addr_x = 7'h63; // c
                     8'h40: addr_x = 7'h74; // t
                     8'h41: addr_x = 7'h65; // e
                     8'h42: addr_x = 7'h6e; // n
                     8'h43: addr_x = 7'h20; // 
                     8'h44: addr_x = 7'h74; // t
                     8'h45: addr_x = 7'h79; // y
                     8'h46: addr_x = 7'h6c; // l
                     8'h47: addr_x = 7'h6b; // k
                     8'h48: addr_x = 7'h6f; // o
                     8'h49: addr_x = 7'h20; // 
                     8'h4a: addr_x = 7'h73; // s
                     8'h4b: addr_x = 7'h69; // i
                     8'h4c: addr_x = 7'h65; // e
                     8'h4d: addr_x = 7'h20; // 
                     8'h4e: addr_x = 7'h20; // 
                     8'h4f: addr_x = 7'h20; // 
                     8'h50: addr_x = 7'h64; // d
                     8'h51: addr_x = 7'h6f; // o
                     8'h52: addr_x = 7'h77; // w
                     8'h53: addr_x = 7'h69; // i
                     8'h54: addr_x = 7'h65; // e
                     8'h55: addr_x = 7'h2c; // ,
                     8'h56: addr_x = 7'h20; // 
                     8'h57: addr_x = 7'h6b; // k
                     8'h58: addr_x = 7'h74; // t
                     8'h59: addr_x = 7'h6f; // o
                     8'h5a: addr_x = 7'h20; // 
                     8'h5b: addr_x = 7'h43; // C
                     8'h5c: addr_x = 7'h69; // i
                     8'h5d: addr_x = 7'h65; // e
                     8'h5e: addr_x = 7'h20; // 
                     8'h5f: addr_x = 7'h20; // 
                     8'h60: addr_x = 7'h73; // s
                     8'h61: addr_x = 7'h74; // t
                     8'h62: addr_x = 7'h72; // r
                     8'h63: addr_x = 7'h61; // a
                     8'h64: addr_x = 7'h63; // c
                     8'h65: addr_x = 7'h69; // i
                     8'h66: addr_x = 7'h6c; // l
                     8'h67: addr_x = 7'h2e; // .
                     8'h68: addr_x = 7'h20; // 
                     8'h69: addr_x = 7'h44; // D
                     8'h6a: addr_x = 7'h7a; // z
                     8'h6b: addr_x = 7'h69; // i
                     8'h6c: addr_x = 7'h73; // s
                     8'h6d: addr_x = 7'h20; // 
                     8'h6e: addr_x = 7'h20; // 
                     8'h6f: addr_x = 7'h20; // 
                     8'h70: addr_x = 7'h70; // p
                     8'h71: addr_x = 7'h69; // i
                     8'h72: addr_x = 7'h65; // e
                     8'h73: addr_x = 7'h6b; // k
                     8'h74: addr_x = 7'h6e; // n
                     8'h75: addr_x = 7'h6f; // o
                     8'h76: addr_x = 7'h73; // s
                     8'h77: addr_x = 7'h63; // c
                     8'h78: addr_x = 7'h20; // 
                     8'h79: addr_x = 7'h54; // T
                     8'h7a: addr_x = 7'h77; // w
                     8'h7b: addr_x = 7'h61; // a
                     8'h7c: addr_x = 7'h20; // 
                     8'h7d: addr_x = 7'h77; // w
                     8'h7e: addr_x = 7'h20; // 
                     8'h7f: addr_x = 7'h20; // 
                     8'h80: addr_x = 7'h63; // c
                     8'h81: addr_x = 7'h61; // a
                     8'h82: addr_x = 7'h6c; // l
                     8'h83: addr_x = 7'h65; // e
                     8'h84: addr_x = 7'h6a; // j
                     8'h85: addr_x = 7'h20; // 
                     8'h86: addr_x = 7'h6f; // o
                     8'h87: addr_x = 7'h7a; // z
                     8'h88: addr_x = 7'h64; // d
                     8'h89: addr_x = 7'h6f; // o
                     8'h8a: addr_x = 7'h62; // b
                     8'h8b: addr_x = 7'h69; // i
                     8'h8c: addr_x = 7'h65; // e
                     8'h8d: addr_x = 7'h20; // 
                     8'h8e: addr_x = 7'h20; // 
                     8'h8f: addr_x = 7'h20; // 
                     8'h90: addr_x = 7'h77; // w
                     8'h91: addr_x = 7'h69; // i
                     8'h92: addr_x = 7'h64; // d
                     8'h93: addr_x = 7'h7a; // z
                     8'h94: addr_x = 7'h65; // e
                     8'h95: addr_x = 7'h20; // 
                     8'h96: addr_x = 7'h69; // i
                     8'h97: addr_x = 7'h20; // 
                     8'h98: addr_x = 7'h6f; // o
                     8'h99: addr_x = 7'h70; // p
                     8'h9a: addr_x = 7'h69; // i
                     8'h9b: addr_x = 7'h73; // s
                     8'h9c: addr_x = 7'h75; // u
                     8'h9d: addr_x = 7'h6a; // j
                     8'h9e: addr_x = 7'h65; // e
                     8'h9f: addr_x = 7'h20; // 
                     8'ha0: addr_x = 7'h62; // b
                     8'ha1: addr_x = 7'h6f; // o
                     8'ha2: addr_x = 7'h20; // 
                     8'ha3: addr_x = 7'h74; // t
                     8'ha4: addr_x = 7'h65; // e
                     8'ha5: addr_x = 7'h73; // s
                     8'ha6: addr_x = 7'h6b; // k
                     8'ha7: addr_x = 7'h6e; // n
                     8'ha8: addr_x = 7'h69; // i
                     8'ha9: addr_x = 7'h65; // e
                     8'haa: addr_x = 7'h20; // 
                     8'hab: addr_x = 7'h70; // p
                     8'hac: addr_x = 7'h6f; // o
                     8'had: addr_x = 7'h20; // 
                     8'hae: addr_x = 7'h20; // 
                     8'haf: addr_x = 7'h20; // 
                     8'hb0: addr_x = 7'h54; // T
                     8'hb1: addr_x = 7'h6f; // o
                     8'hb2: addr_x = 7'h62; // b
                     8'hb3: addr_x = 7'h69; // i
                     8'hb4: addr_x = 7'h65; // e
                     8'hb5: addr_x = 7'h21; // !
                     default: addr_x = 7'h20;        
        endcase
        end
        
    
    
endmodule

                     