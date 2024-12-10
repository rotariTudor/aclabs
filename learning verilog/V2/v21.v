module v21(input [3:0]in,output [1:0]out);  
  assign out[0] = (~in[1] & ~in[0]) | (in[1] & in[0]);
  assign out[1] = (~in[0]);
endmodule

module v21_tb();
  reg [3:0]in;
  wire [1:0]out;
  v21 CUT(.in(in),.out(out));
  integer i;
  initial begin
    in=0;
    $display("TIME\tIN\tOUT 0\tOUT 1");
    $monitor("%0t\t%b\t%b\t%b",$time,in,out[0],out[1]);
    for(i=1;i<16;i=i+1)begin
      #10 in=i;
    end
  end
endmodule