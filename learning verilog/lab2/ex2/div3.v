module div3 (
  input [3:0] i,
  output reg [2:0] o
);
  always@(*)begin
    if({i[3],i[2],i[1],i[0]}>=0 && {i[3],i[2],i[1],i[0]}<3)begin
      o=0;
    end
    if({i[3],i[2],i[1],i[0]}>=3 && {i[3],i[2],i[1],i[0]}<6)begin
      o=1;
    end
    if({i[3],i[2],i[1],i[0]}>=6 && {i[3],i[2],i[1],i[0]}<9)begin
      o=2;
    end
    if({i[3],i[2],i[1],i[0]}>=9 && {i[3],i[2],i[1],i[0]}<12)begin
      o=3;
    end
    if({i[3],i[2],i[1],i[0]}>=12 && {i[3],i[2],i[1],i[0]}<15)begin
      o=4;
    end
    if({i[3],i[2],i[1],i[0]}==15)begin
      o=5;
    end
  end
endmodule

module div3_tb;
  reg [3:0] i;
  wire [2:0] o;

  div3 div3_i (.i(i), .o(o));

  integer k;
  initial begin
    $display("Time\ti\t\to");
    $monitor("%0t\t%b(%2d)\t%b(%0d)", $time, i, i, o, o);
    i = 0;
    for (k = 1; k < 16; k = k + 1)
      #10 i = k;
  end
endmodule