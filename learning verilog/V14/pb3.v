`include "pb1.v"
`include "pb2.v"

module ORA(input clk, input rst_b, input [3:0]i, output [3:0]out);
  generate
    genvar i;
    for(i=0;i<4;i=i+1)begin : loop
      if(i==0) 
    end
  endgenerate
endmodule