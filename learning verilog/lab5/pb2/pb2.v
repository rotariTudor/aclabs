module patt(input clk, input rst_b, input i, output reg o);
  localparam s0=0,s1=1,s2=2,s3=3,s4=4;
  reg [3:0]state;
  reg [3:0]next_state;
  
  always@(*)begin
    o=0;
    next_state=state;
    case(state)
      s0:begin
        o=0;
        if(i)next_state=s1;
        else next_state=s0;
        end
      s1:begin
        o=0;
        if(!i)next_state=s2;
        else next_state=s1;
      end
      s2:begin
        o=0;
        if(i)next_state=s3;
        else next_state=s0;
      end
      s3:begin
        o=0;
        if(i)next_state=s4;
        else next_state=s2;
      end
      s4:begin
        o=1;
        if(i)next_state=s1;
        else next_state=s2;
      end
    endcase
  end
  
  
  always@(posedge clk,negedge rst_b)begin
    if(!rst_b)begin
      state<=s0;
    end
    else begin
      state<=next_state;
    end
  end
endmodule

module patt_tb;
  reg clk,rst_b,i;
  wire o;
  patt CUT(.clk(clk),.rst_b(rst_b),.i(i),.o(o));
  initial begin
    clk=0;
    rst_b=0;
    i=1;
    forever #50 clk=~clk;
  end
  
  initial begin
    #25 rst_b=1;
  end
  
  initial begin
  #140;
  i=1;
  #100;
  i=0;
  #100;
  i=1;
  #100;
  i=1;
  #100;
  i=0;
  #100;
  i=1;
  #100;
  i=1;
  end
endmodule