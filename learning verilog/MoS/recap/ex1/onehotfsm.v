//Automat one-hot

//peste tot avem wire-uri

module fsm_one_hot(input clk,input rst,output out);
  
  wire [1:0] st_next;
  reg [1:0] st;
  
  localparam s1=0;
  localparam s2=1;
  localparam s3=2;
  
  assign st_next[s1]=st[s3]&in;
  assign st_next[s2]=(st[s1]&in) | (st[s3] & ~in) | (st[s2] & in);
  assign st_next[s3]=(st[s1] & ~in)|(st[2] & ~in);
  assign out = st[s1] | st[s3];
  
  always@(posedge clk,negedge rst)begin
    if(!rst)begin
      st<=0;
      st[s1]<=1;
    end
    else begin
      st<=st_next;
    end
  end
endmodule