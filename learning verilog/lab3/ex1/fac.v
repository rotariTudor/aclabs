module fac(input x, input y, input cin, output sum, output carryout);
  assign sum = x ^ y ^ cin;
  assign carryout = (x&y)|(y&cin)|(cin&x);
endmodule

module fac_tb();
  reg x;
  reg y;
  reg cin;
  wire sum;
  wire carryout;
  fac fac1(.x(x),.y(y),.cin(cin),.sum(sum),.carryout(carryout));
  integer i;
  initial begin
    $display("TIME\tCIN\tX\tY\tSUM\tCARRY-OUT\t");
    {cin,x,y}=0;
    $monitor("%0t\t%b\t%b\t%b\t%b\t%b",$time,cin,x,y,sum,carryout);
    for(i=1;i<8;i=i+1)begin
      #10 {cin,x,y}=i;
      
    end
  end
endmodule