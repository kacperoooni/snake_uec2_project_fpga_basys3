
`timescale 1 ns / 1 ps

module VGA_timing_controller (
  output wire [15:0] vcount,
  output wire vsync,
  output wire vblnk,
  output wire [15:0] hcount,
  output wire hsync,
  output wire hblnk,
  input wire clk,
  input wire rst
  );

reg [15:0]v, v_nxt;
reg [15:0]h, h_nxt;

initial begin
    v=0;
    h=0;
end

always @*
begin
    if (hcount==1343)
    begin
        h_nxt=0;
        v_nxt=vcount+1;
        if (vcount==805) v_nxt=0;
        else #0;
    end
    else begin
        h_nxt=hcount+1;
        v_nxt=vcount;
    end
end

always @ (posedge clk or posedge rst)
begin
    if (rst)
    begin
        v<=0;
        h<=0;
    end
    else
    begin
        v<=v_nxt;
        h<=h_nxt;
    end
end

assign vcount=v;
assign hcount=h;
assign vsync=((v>=772) &&(v<=776));
assign hsync=((h>=1049) && (h<=1184));
assign vblnk=((v>=768) && (v<=806));
assign hblnk=((h>=1025) && (h<=1344));

endmodule

