module sadd(input clk, input rst_b, input [1:0]in, output reg z);
  
  localparam s0=0;
  localparam s1=1;
  
  reg st;
  reg st_next;
  always@(*)begin
    st_next=st;
    z=0;
    case(st)
      s0:begin
        if(in==2'b11)begin
          st_next=s1;
          z=0;
        end
        else begin
          st_next=s0;
          if(in==2'b00) z=0;
            else if(in==2'b01||in==2'b10) z=1;
          end
      end
      s1:begin
        if(in==2'b00)begin
          st_next=s0;
          z=1;
        end
        else begin
          st_next=s1;
          if(in==2'b11) z=1;
            else if(in==2'b01 || in==2'b10)z=0;
        end
      end
    endcase
  end  
  
  always@(posedge clk, negedge rst_b)begin
    if(!rst_b) st<=s0;
    else st<=st_next;
  end
endmodule


module sadd_tb;
  reg clk,rst_b;
  reg[1:0]in;
  wire z;

  sadd CUT(.clk(clk),.rst_b(rst_b),.in(in),.z(z));
  
  initial begin
    clk=0;
    forever #50 clk=~clk;
  end
  
  initial begin
    rst_b=0;
    in=2'b01;
    #25 rst_b=1;
  end
    
    initial begin
      #100;
      in[1]=1;
      #200;
      in[1]=0;
    end
    
    initial begin
      #200;
      in[0]=0;
    end
endmodule