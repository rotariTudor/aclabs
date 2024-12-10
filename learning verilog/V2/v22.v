module register(input d, input ld, input clk, input rst_b, output reg q);
  always@(posedge clk,negedge rst_b)begin
    if(!rst_b)begin
      q<=0;
    end 
    else if (ld) begin
      q<=d;
    end
  end
endmodule

module register_tb();
  reg d;
  reg ld;
  reg clk;
  reg rst_b;
  wire q;
  register CUT(.d(d),.ld(ld),.clk(clk),.rst_b(rst_b),.q(q));
  
  initial begin
    clk = 0;
    rst_b = 0;
  end
  
  integer i;
  initial begin
    for(i = 0; i < 100; i = i + 1) begin
      #50 clk = ~clk;
    end
  end
  
  initial begin
    #25 rst_b = 1;  
  end
endmodule