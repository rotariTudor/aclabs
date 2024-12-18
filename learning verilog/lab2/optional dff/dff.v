module top_module(input clk, input d, input reset, output reg out);
  always@(posedge clk)begin
    if(reset)begin
      out<=0;
    end
    else begin
      out<=d;
    end
  end
endmodule

module top_module_dff;
	reg clk;
	reg d;
	reg reset;
	wire out;

	top_module dff_example(.clk(clk), .d(d), .reset(reset) ,.out(out));

  initial begin
    clk=0;
	  forever #5 clk=~clk;
	end  
	
  initial begin
    reset=1;
    d=0;
    #20
    reset=0;
    #10 d = 1;
    #10 d = 0;
    #10 d = 1;
    #20 reset = 1;
    #10 reset = 0;
    #10 d = 0;
    #50 $stop;
  end
  initial begin
    $monitor("Time: %0t | clk : %b | reset: %b | d: %b | out: %b",$time,clk,reset,d,out);
  end
endmodule