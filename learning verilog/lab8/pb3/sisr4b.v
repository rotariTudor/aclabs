module dff(input clk,input rst_b,input d, output reg o);
  always@(posedge clk,negedge rst_b)begin
    if(!rst_b)begin
      o<=0;
    end
    else o<=d;
  end
endmodule


module sisr4b(input in,input clk, input rst_b, output[3:0]q);
  generate
    genvar i;
    for(i=0;i<4;i=i+1)begin
      if(i==1)begin
        dff d1(.clk(clk),.rst_b(rst_b),.d(q[i-1]^q[3]),.o(q[i]));
      end
      else if(i==0)begin
        dff d2(.clk(clk),.rst_b(rst_b),.d(in^q[3]),.o(q[i]));
      end
      else 
        dff d3(.clk(clk),.rst_b(rst_b),.d(q[i-1]),.o(q[i]));
    end
  endgenerate
endmodule

module sisr4b_tb();
  reg in;
  reg clk;
  reg rst_b;
  wire [3:0]q;
  
  sisr4b CUT(.in(in),.clk(clk),.rst_b(rst_b),.q(q));
  
  
  initial begin
  clk=0;
  rst_b=0;
  in=0;
  end
  
  integer i;
  initial begin
  for(i=0;i<10;i=i+1)begin
    #100; clk=~clk; 
    #150; in=~in;
    end
  end
  
  initial begin
    #25;
    rst_b=1;
  end
  
endmodule