module ex1(input [3:0] i, output [3:0] o);
  assign o[0]=i[1]^i[0];
  assign o[1]=i[2]^i[1];
  assign o[2]=i[2]|i[3];
  assign o[3]=i[3];
  
endmodule

module ex1_tb;
  reg [3:0] i;
  wire [3:0] o;
  
  ex1 dut(
    .i(i),
    .o(o)
  );
  
  integer k;
  initial begin
    {i}=0;
    $monitor("%b\t%b",i,o);
    for(k=0;k<16;k=k+1) begin
      #10 {i}=k;
    end
  end
��
