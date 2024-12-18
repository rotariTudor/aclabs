module add2b(input [1:0]x,input[1:0]y,input cin,output [1:0]sum, output carryout);
  wire w1;
  fac fac1(.x(x[0]),.y(y[0]),.cin(cin),.sum(sum[0]),.carryout(w1));
  fac fac2(.x(x[1]),.y(y[1]),.cin(w1),.sum(sum[1]),.carryout(carryout));
endmodule

module fac(input x, input y, input cin, output sum, output carryout);
  assign sum = x ^ y ^ cin;
  assign carryout = (x&y)|(y&cin)|(cin&x);
endmodule

module add2b_tb();
  reg [1:0]x;
  reg [1:0]y;
  reg cin;
  wire [1:0]sum;
  wire carryout;
  add2b cut(.x(x),.y(y),.cin(cin),.sum(sum),.carryout(carryout));
  integer i;
  initial begin
    {x,y,cin}=0;    
    $display("TIME\tX\tY\tCIN\tSUM\tCO");
    $monitor("%0t\t%b\t%b\t%b\t%b\t%b",$time,x,y,cin,sum,carryout);
    for(i=1;i<32;i=i+1)begin
      #10 {x,y,cin}=i;
    end
  end
endmodule
  