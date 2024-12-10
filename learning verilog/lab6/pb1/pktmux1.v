module pktmux(
    input [63:0]pkt,
    input pad_pkt,
    input zero_pkt,
    input mgln_pkt,
    input [63:0]msg_len,
    output reg [63:0]out
);
  always@(*)begin
    if(zero_pkt) out = 0;
      else if(pad_pkt) out = 1'b1 << 63;
        else if(mgln_pkt) out = msg_len;
          else out = pkt;
  end
  
endmodule

module pktmux_tb;
  reg pad_pkt;
  reg zero_pkt;
  reg mgln_pkt;
  reg [63:0]msg_len;
  reg [63:0]pkt;
  wire [63:0]out;
  
  pktmux CUT(.pkt(pkt),
  .pad_pkt(pad_pkt),
  .zero_pkt(zero_pkt),
  .mgln_pkt(mgln_pkt),
  .msg_len(msg_len),
  .out(out));
  
  task urand64(output reg [63:0]r);
    begin 
      r[63:32]=$urandom;
      r[31:0]=$urandom;
    end
  endtask
  
  integer i;
  
  initial begin
    for(i=0;i<10;i=i+1)begin
      #100; urand64(pkt);
      urand64(msg_len);
    end
  end
  
  
initial begin
  #100; pad_pkt = 1;
  #100; pad_pkt = 0;
  #300; pad_pkt = 1;
  #100; pad_pkt = 0;
  #300; pad_pkt = 1;
  #100; pad_pkt = 0;
end

initial begin
  #200; zero_pkt = 1;
  #100; zero_pkt = 0;
  #300; zero_pkt = 1;
  #100; zero_pkt = 0;
  #300; zero_pkt = 1;
  #100; zero_pkt = 0;
end

initial begin
  mgln_pkt=0;
  #300; mgln_pkt = 1;
  #100; mgln_pkt = 0;
  #300; mgln_pkt = 1;
  #100; mgln_pkt = 0;
  #300; mgln_pkt = 1;
  #100; mgln_pkt = 0;
end  
endmodule