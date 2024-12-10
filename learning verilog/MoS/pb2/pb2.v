module ffd(
  input d,
  input clk,
  input set,
  output reg q
);

always @(posedge clk or negedge set) begin
  if(!set)
    q <= 1;
  else
    q <= d;
end
endmodule

module lfsr(
  input clk,
  input rst_b,
  output [5:0]q
);

generate
  genvar i;
  for(i = 0; i < 6; i = i + 1) begin
    if(i == 2 || i == 4 || i == 5)
      ffd f1(
        .d(q[5] ^ q[i-1]),
        .clk(clk),
        .set(rst_b),
        .q(q[i])
      );
    else
      if(i == 0)
        ffd f2(
        .d(q[5]),
        .clk(clk),
        .set(rst_b),
        .q(q[i])
      );
      else
        ffd f3(
         .d(q[i-1]),
         .clk(clk),
         .set(rst_b),
         .q(q[i])
        );
  end
endgenerate

endmodule

module lfsr_tb;
  
  reg clk, rst_b;
  wire [5:0]q;
  
  lfsr CUT(
    .clk(clk),
    .rst_b(rst_b),
    .q(q)
  );
  
  initial begin
    clk = 0;
    rst_b = 0;
  end
  
  integer i;
  initial begin
    for(i = 0; i < 100; i = i + 1) begin
      #50; clk = ~clk;
    end
  end
  
  initial begin
    #25; rst_b = 1;
  end
  
endmodule