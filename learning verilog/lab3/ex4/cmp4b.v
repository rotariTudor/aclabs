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

module cmp4b(input[3:0]x,input [3:0]y,output reg eq, output reg lt, output reg gt);
  wire eq_low, lt_low, gt_low;
  wire eq_high, lt_high, gt_high;
  
  cmp2b cmp2_l(.x(x[1:0]),.y(y[1:0]),.eq(eq_low),.lt(lt_low),.gt(gt_low));
  cmp2b cmp2_h(.x(x[3:2]),.y(y[3:2]),.eq(eq_high),.lt(lt_high),.gt(gt_high));
  always@(*)begin
    if(eq_high && eq_low)begin
      eq=1;
      lt=0;
      gt=0;
    end
    if(lt_high || (eq_high && eq_low))begin
      eq=0;
      lt=1;
      gt=0;
    end
    else begin
      eq=0;
      lt=0;
      gt=1;
    end
  end
endmodule


module cmp4b_tb();
  reg [3:0]x;
  reg [3:0]y;
  wire eq;
  wire lt;
  wire gt; 
  
  cmp4b CUT(.x(x),.y(y),.eq(eq),.lt(lt),.gt(gt));
  
  integer i;
  initial begin
    {x,y}=0;
    $display("TIME\tX\tY\tEQ\tLT\tGT");
    $monitor("%0t\t%b\t%b\t%b\t%b\t%b",$time,x,y,eq,lt,gt);
    for(i=1;i<256;i=i+1)begin
      #10 {x,y}=i;
    end
  end
endmodule