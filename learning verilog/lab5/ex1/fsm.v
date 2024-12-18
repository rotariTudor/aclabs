module fsm(input clk, input rst_b, input a, input b, input c, output reg m, output reg n);
  
  localparam s0_st=2'd0;
  localparam s1_st=2'd1;
  localparam s2_st=2'd2;
  localparam s3_st=2'd3;
  
  reg [1:0]st;
  reg [1:0]st_next;
  
  always@(*)
    case(st)
      s0_st: if(!a) st_next =s0_st;
                else if(b) st_next = s2_st;
                else st_next = s1_st;
      s1_st: st_next = s2_st;
      s2_st: if(c) st_next = s3_st;
              else st_next = s1_st;
      s3_st: if(b) st_next = s0_st;
              else st_next = s3_st;
    endcase
    
    always@(*)begin
      m=1'd0;
      n=1'd0;
      case(st)
        s0_st: if(!a) {m,n}=2'b11;
                else if (b) n=1'd1;
                  else m = 1'd1;
        s1_st: m=1'd1;
        s2_st: if(c) n=1'd1;
        s3_st: n = 1'd1;
      endcase
    end
    
    always@(posedge clk, negedge rst_b)
      if(!rst_b) st<=s0_st;
        else st<=st_next;
endmodule


module fsm_tb;

  reg clk;
  reg rst_b;
  reg a;
  reg b;
  reg c;

  wire m;
  wire n;

  fsm CUT (.clk(clk),.rst_b(rst_b),.a(a),.b(b),.c(c),.m(m),.n(n));

  initial begin
    clk = 0;
    forever #5 clk = ~clk; 
  end

  initial begin
    rst_b = 0;
    a = 0;
    b = 0;
    c = 0;

    #10;
    rst_b = 1;

    // Test case 1: Stay in s0
    #10 a = 0; b = 0; c = 0;

    // Test case 2: Transition to s1
    #10 a = 1; b = 0; c = 0;

    // Test case 3: Transition to s2
    #10 a = 1; b = 1; c = 0;

    // Test case 4: Transition to s3
    #10 a = 1; b = 1; c = 1;

    // Test case 5: Go back to s0
    #10 a = 1; b = 1; c = 0;

    // Test case 6: Stay in s3
    #10 a = 0; b = 0; c = 1;
    #50;
    $finish;
  end

  initial begin
    $display("TIME\tCLK\tRST_B\tA\tB\tC\tST\tM\tN");
    $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b",$time, clk, rst_b, a, b, c, CUT.st, m, n);
  end

endmodule
