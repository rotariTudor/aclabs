module check #(parameter w=4)(input [w:0]in,output reg o);
  always@(*)begin
    if(((in+3)%4)==0)begin
      o=1'b1;
    end
    else o=1'b0;
  end
endmodule

module check_tb;
  localparam w=4;
  reg [w:0]in;
  wire o;
  check CUT(.in(in),.o(o));
  integer i;
  initial begin
    {in}=0;
    $display("I\tO");
    $monitor("%b\t%b",in,o);
    for(i=0;i<32;i=i+1)begin
    #10 {in}=i;
    end
  end
endmodule