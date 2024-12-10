module v2(input [4:0]in,output reg [3:0]out);
  always@(*)begin
    if(in<10)begin
      out=in;
    end
    else begin
      out=in/10;
    end
  end
endmodule

module v2_tb();
  reg [4:0]in;
  wire [3:0]out;
  v2 CUT(.in(in),.out(out));
  integer i;
  initial begin
    in=0;
  $display("TIME\tIN\tOUT");
  $monitor("%0t\t%d\t%d",$time,in,out);
    for(i=1;i<16;i=i+1)begin
      #10 {in}=i;
    end
  end
endmodule