module msd_c1(input [5:0]in,output reg[4:0]out);
  
  reg [5:0] sm;
  reg [3:0] digit;
  
  always@(*)begin
    digit = 0;
    if(in[5]==0)begin
      sm=in;
    end
    else begin
      sm={in[5],~in[4:0]};
    end
    while(sm!=0)begin
      digit=sm%10;
      sm=sm/10;
    end
    out={~in[5],digit};
  end
endmodule

module msd_c1_tb();
  reg [5:0]in;
  wire [4:0]out;
  
  msd_c1 CUT(.in(in),.out(out));
  
  integer i;
  
  initial begin
    $display("TIME\tIN\tOUT");
    {in}=0;
    $monitor("%0t\t%d\t%b",$time,in,out);
    for(i=1;i<32;i=i+1)begin
      #10 {in}=i;
    end
  end
endmodule