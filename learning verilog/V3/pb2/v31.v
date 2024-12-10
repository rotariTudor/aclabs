module karnaugh #(parameter w=4)(input [3:0] in,output [1:0] o);
  assign o[0]=~in[0];
  assign o[1]=in[0];
endmodule

module karnaugh_tb;
  localparam w=4;
  reg [3:0]in;
  wire [1:0]o;
  
  karnaugh CUT(.in(in),.o(o));
  integer i;
  initial begin
    $display("TIME\tI\tO");
    $monitor("%0t\t%b\t%b",$time,in,o);
    {in}=0;
    for(i = 1; i < 15;i=i+1)begin
      #10 {in}=i;
    end
  end
endmodule