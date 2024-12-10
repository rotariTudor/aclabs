module cmp2b(input [1:0]x,input [1:0]y,output reg eq, output reg lt, output reg gt);
  always@(*)begin
    gt=0;lt=0;eq=0;
    if(x>y)begin
      gt=1;
    end
    else if(x<y)begin
      lt=1;
    end
    else begin
      eq=1;
    end
  end
endmodule


module cmp2b_tb();
  reg [1:0]x;
  reg [1:0]y;
  wire eq;
  wire lt;
  wire gt;
  
  cmp2b CUT(.x(x),.y(y),.eq(eq),.lt(lt),.gt(gt));
  
  integer i;
  
  initial begin
    $display("TIME\tX\tY\tEQ\tLT\tGT");
    {x,y}=0;
    $monitor("%0t\t%b\t%b\t%b\t%b\t%b",$time,x,y,eq,lt,gt);
    for(i=1;i<16;i=i+1)begin
      #10 {x,y}=i;
    end
  end
endmodule