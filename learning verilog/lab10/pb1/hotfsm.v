module hotfsm(input a, input b, input c, input clk, input rst_b, output m, output n);
  localparam s0=2;
  localparam s1=0;
  localparam s2=3;
  localparam s3=1;
  
  reg [3:0] st;
  wire [3:0]st_nxt;
  
  assign st_nxt[s0] = (st[s0] & (~a)) | (st[s3] & b);
  assign st_nxt[s1] = (st[s0] & a & (~b)) | (st[s2] & (~c));
  assign st_nxt[s2] = st[s1] | (st[s0] & a & b);
  assign st_nxt[s3] = (st[s2] & c) | (st[s3] & (~b));

  assign m = (st[s0] & (~a)) | (st[s0] & a & (~b)) | st[s1];
  assign n = (st[s0] & (~a)) | (st[s0] & a & b) | (st[s2] & c) | (st[s3] & (~b));

  always@(posedge clk,negedge rst_b)begin
    if(rst_b==0)begin
      st<=0;
      st[s0]<=1;
    end
    else st<=st_nxt;
  end
  
endmodule


module hotfsm_tb;

  reg clk;
  reg rst_b;
  reg a;
  reg b;
  reg c;
  wire m;
  wire n;

  hotfsm CUT (
      .a(a),
      .b(b),
      .c(c),
      .clk(clk),
      .rst_b(rst_b),
      .m(m),
      .n(n)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk; 
  end

  initial begin
    rst_b = 0;
    a = 0;
    b = 0;
    c = 0;
    
    #10 rst_b = 1;
    
    #10 a = 1; b = 0; c = 0;
    #10 a = 0; b = 1; c = 0;
    #10 a = 1; b = 1; c = 0;
    #10 a = 0; b = 0; c = 1;
    #10 a = 1; b = 0; c = 1;
    #10 a = 0; b = 1; c = 1;
    #10 a = 1; b = 1; c = 1;
    
    #50 $stop;
  end

  initial begin
    $display("TIME\tRST_B\tA\tB\tC\t\tM\tN");
    $monitor("%0t\t%b\t%b\t%b\t%b\t\t%b\t%b", $time, rst_b, a, b, c, m, n);
  end

endmodule

