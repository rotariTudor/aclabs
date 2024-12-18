module counter #(
      parameter width = 8, initval = 8'hF
      )(
      input clk,
      input rst_b,
      input c_up,
      input clr,
      output reg [width-1:0]q
      );

  always@(posedge clk, negedge rst_b)begin
    if(~rst_b)begin
      q<=initval;
    end
    else if (clr) begin
      q<=initval;
    end
    else if(c_up)begin
      q<=q+1;
    end
  end

endmodule


module counter_tb();
  reg clk;
  reg rst_b;
  reg c_up;
  reg clr;
  wire [7:0]q;
  
  counter #(8,8'hF) CUT (.clk(clk),.rst_b(rst_b),.c_up(c_up),.clr(clr),.q(q));
  
  always begin
    clk=1; #50;
    clk=0; #50;
  end
  
  
  initial begin
    rst_b=1; c_up=0; clr=0;
    
    #5 rst_b = 0;
    #10 rst_b = 1;
    
    #10 c_up = 1;
    #100 c_up = 0;  
    
    #20 clr = 1;
    #10 clr = 0;

        
    #10 c_up = 1;
    #50 c_up = 0;
    
    #200 $finish;
  end
  
  initial begin
  $display("TIME\tQ\tRST_B\tC_UP\tCLR");
  $monitor("%0t\t%h\t%b\t%b\t%b", $time, q, rst_b, c_up, clr);
  end
  
endmodule