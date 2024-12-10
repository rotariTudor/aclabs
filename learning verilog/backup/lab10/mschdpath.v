module rgst #(
    parameter w=8
)(
    input clk, rst_b, ld, clr, 
    input [w-1:0] d, 
    output reg [w-1:0] q
);
    always @ (posedge clk, negedge rst_b)
        if (!rst_b)                 q <= 0;
        else if (clr)               q <= 0;
        else if (ld)                q <= d;
endmodule

module muxC #(
  parameter w=32
)(
  input [w-1:0] i1, i0,
  input s,
  output [w-1:0] o
);

assign o = (s) ? i1 : i0;

endmodule

module sigma0 (
  input [31:0] in,
  output [31:0] out
);

function [31:0] RotireDr (input [31:0] x, input [4:0] p);
  reg [63:0] tmp;
  begin
    tmp = {x, x} >> p;
    RotireDr = tmp[31:0];
  end
endfunction

function [31:0] DeplasareDr (input [31:0] x, input [4:0] p);
  reg [63:0] tmp;
  begin
    tmp = {32'b0, x} >> p;
    DeplasareDr = tmp[31:0];
  end
endfunction

assign out = RotireDr(in, 7) ^ RotireDr(in, 18) ^ DeplasareDr(in, 3);

endmodule

module sigma1 (
  input [31:0] in,
  output [31:0] out
);

function [31:0] RotireDr (input [31:0] x, input [4:0] p);
  reg [63:0] tmp;
  begin
    tmp = {x, x} >> p;
    RotireDr = tmp[31:0];
  end
endfunction

function [31:0] DeplasareDr (input [31:0] x, input [4:0] p);
  reg [63:0] tmp;
  begin
    tmp = {32'b0, x} >> p;
    DeplasareDr = tmp[31:0];
  end
endfunction

assign out = RotireDr(in, 17) ^ RotireDr(in, 19) ^ DeplasareDr(in, 10);

endmodule

module mschdpath(
  input clk, rst_b, ld_mreg, upd_mreg,
  input [511:0] blk,
  output [31:0] m0
);

wire [31:0] m [15:0];
wire [31:0] outMux [15:0];
wire [31:0] temp1, temp2;

genvar i;

generate
  for(i = 0; i < 16; i = i + 1) begin
    if(i == 0) begin
      muxC #(.w(32)) MUX0(
        .i1(blk[511:480]),
        .i0(m[1]),
        .s(ld_mreg),
        .o(outMux[0])
      );
      rgst #(.w(32)) REG0 (
        .clk(clk),
        .rst_b(rst_b),
        .ld(upd_mreg),
        .clr(1'b0),
        .d(outMux[0]),
        .q(m0)
      );
    end
    else if(i == 1) begin
      muxC #(.w(32)) MUX1(
        .i1(blk[479:448]),
        .i0(m[2]),
        .s(ld_mreg),
        .o(outMux[1])
      );
      rgst #(.w(32)) REG1 (
        .clk(clk),
        .rst_b(rst_b),
        .ld(upd_mreg),
        .clr(1'b0),
        .d(outMux[1]),
        .q(m[1])
      );
      sigma0 S0(
        .in(m[1]),
        .out(temp1)
      );
    end
    else if(i == 14) begin
      muxC #(.w(32)) MUX14(
        .i1(blk[63:32]),
        .i0(m[15]),
        .s(ld_mreg),
        .o(outMux[14])
      );
      rgst #(.w(32)) REG14 (
        .clk(clk),
        .rst_b(rst_b),
        .ld(upd_mreg),
        .clr(1'b0),
        .d(outMux[14]),
        .q(m[14])
      );
      sigma1 S1(
        .in(m[14]),
        .out(temp2)
      );
    end
    else if(i == 15) begin
      muxC #(.w(32)) MUX15(
        .i1(blk[31:0]),
        .i0(m0 + temp1 + temp2 + m[9]),
        .s(ld_mreg),
        .o(outMux[15])
      );
      rgst #(.w(32)) REG0 (
        .clk(clk),
        .rst_b(rst_b),
        .ld(upd_mreg),
        .clr(1'b0),
        .d(outMux[15]),
        .q(m[15])
      );
    end
    else begin
      muxC #(.w(32)) MUX(
        .i1(blk[((32*(16-i))-1) : ((32*(15-i)))]),
        .i0(m[i + 1]),
        .s(ld_mreg),
        .o(outMux[i])
      );
      rgst #(.w(32)) REG (
        .clk(clk),
        .rst_b(rst_b),
        .ld(upd_mreg),
        .clr(1'b0),
        .d(outMux[i]),
        .q(m[i])
      );
    end
  end
endgenerate

endmodule

module mschdpath_tb;
reg clk, rst_b, ld_mreg, upd_mreg;
reg [511:0] blk;
wire [31:0] m0;

mschdpath cut(
  .clk(clk),
  .rst_b(rst_b),
  .ld_mreg(ld_mreg),
  .upd_mreg(upd_mreg),
  .blk(blk),
  .m0(m0)
);

initial begin
  clk = 0;
  rst_b = 0;
  ld_mreg = 1;
  upd_mreg = 1;
  blk = 512'h6162636430313233800000040;
end

integer i;
initial begin
  for(i = 1; i <= 128; i = i + 1) begin
    #50; clk = ~clk;
  end
end

initial begin
  #25; rst_b = 1;
end

initial begin
  #100; ld_mreg = 0;
end
  
endmodule