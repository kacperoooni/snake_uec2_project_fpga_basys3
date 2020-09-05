//Listing 8.5
module uart_test
   (
    input wire clk, reset,
    input wire rx,
    input wire [2:0] btn,
    output wire tx, sw,
    output wire [3:0] an,
    output wire [6:0] sseg, led
   );

    reg [15:0] words, words_nxt;
    wire tx_full, rx_empty, sw_bounce ; 
    reg btn_tick, btn_tick_nxt;
    wire [7:0] rec_data, rec_data1;

    always@(*)
    begin
    if((~rx_empty) && (btn_tick == 0))
        begin
        words_nxt[7:0] = rec_data;
        words_nxt[15:8] = words[7:0];
        btn_tick_nxt = 1;
        end
    else
        begin
        words_nxt[7:0] = words[7:0];
        words_nxt[15:8] = words[15:8];
        btn_tick_nxt = 0;
        end    
    end
    
    always@(posedge clk)
    begin
    btn_tick <= btn_tick_nxt;
    words <= words_nxt;
    end
    
    
    


   // signal declaration
   disp_hex_mux disp_hex_mux (
   .clk(clk),
   .hex0(words[3:0]),
   .hex1(words[7:4]),
   .hex2(words[11:8]),
   .hex3(words[15:12]),
   .an(an),
   .sseg(sseg),
   .dp_in(4'b1111)
   );
   // body
   // instantiate uart
   uart uart_unit
      (.clk(clk), .reset(reset), .rd_uart(btn_tick),
       .wr_uart(sw_bounce), .rx(rx), .w_data(words[7:0]),
       .tx_full(tx_full), .rx_empty(rx_empty),
       .r_data(rec_data), .tx(tx));
   // instantiate debounce circuit
   debounce btn_db_unit
      (.clk(clk), .reset(reset), .sw(sw),
       .db_level(), .db_tick(sw_bounce));
   // incremented data loops back
   assign rec_data1 = rec_data + 1;
   // LED display
   assign led = rec_data;

endmodule