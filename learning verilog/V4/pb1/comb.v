module comb(input [3:0]i,output [2:0]q);
  always@(*)begin
    if({i}>=0 && {i}<=3)begin
      q = (2*i+7)%6;
    end
    else if({i}>=4 && {i}<=10)begin
      q = (3*i+2)%8;
    end
    else q = (i/3);
  end
endmodule