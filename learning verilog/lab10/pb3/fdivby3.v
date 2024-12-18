module fdivby3(
    input clk,rst_b,clr,c_up,
    output fdclk
);
  localparam s0=0,s1=1,s2=2;
  reg [2:0]st;
  wire [2:0]stnext;
  assign stnext[s0] = (st[s0] & (~c_up | clr)) | (st[2] & (c_up | clr))| (st[1] & clr);
  assign stnext[s1] = (st[s0] & ( c_up & ~clr )) | (st[s1] & ~c_up & ~clr);
  assign stnext[s2] = (st[s1] & c_up & ~clr) | (st[s2] & ~c_up & ~clr);
  
  assign fdclk = st[s0];
  
  always@(posedge clk, negedge rst_b)begin
    if(!rst_b)begin
      st<=3'b001;
    end
    else begin
      st<=stnext;
    end
  end
endmodule

module fdivby3_tb;
  reg clk, rst_b, clr, c_up;
  wire fdclk;
  
  fdivby3 CUT(.clk(clk),.rst_b(rst_b),.clr(clr),.c_up(c_up),.fdclk(fdclk));
  
  initial begin
    clk=0;
    rst_b=0;
    clr=0;
    c_up=1;
  end
  
  integer i;
  
  initial begin
    for(i=0;i<30;i=i+1)begin
      #50 clk=~clk;
    end
  end
  
  initial begin
  #25 rst_b=1;
  end
  
  initial begin
    #400 clr=1;
    #100 clr=0;
  end
  
  initial begin
    #600 c_up=0;
    #100 c_up=1;
    #400 c_up=0;
    #200 c_up=1;
  end
  
endmodule