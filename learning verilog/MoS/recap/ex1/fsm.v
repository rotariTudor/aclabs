module fsm #(
  parameter size = 3;)(
  input clk;
  input rst;
  input in;
  output out;
  );
  reg st[1:0];//determinat sau setat secvential
  reg st_next[1:0];//determinat combinational
  
  //automat Moore
  
  localparam s1=0;
  localparam s2=1;
  localparam s3=2;
  
  always@(*)begin
    case(st)
      s1: 
      out=1;
      if(in==1)begin
        st_next=s1;
      end 
      else begin
        st_next=s3;
      end
      s2:
        out=1;
      if(in==1)begin
        st_next=s2;
      end
      else begin
        st_next=s3;
      end
      s3:
      out=0;
      if(in==1)begin
        st_next = s1;
      end
      else begin
        st_next=s2;
      end
    endcase
  end
  
  always@(posedge,negedge rst)begin
    if(!rst)begin
      st<=s1;
    end
    else begin
      st<=st_next;
    end
  end

endmodule