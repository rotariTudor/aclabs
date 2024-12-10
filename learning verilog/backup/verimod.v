module dff(
  input clk,
  input reset_b,
  input set_b,
  input d,
  output reg q
);

  always@(posedge clk or negedge set_b or negedge reset_b) begin
    if(~set_b) q <= 1'b1;
    else if(~reset_b) q <= 1'b0;
    else q <= d;
  end

endmodule



module register #(
  parameter width = 8,
  parameter initialValue = {width{1'b0}}
)(
  input clk,
  input reset_b,
  input [width-1:0]loadData,
  input load,
  input clear,
  output reg [width-1:0]registerData
);

  always@(posedge clk or negedge reset_b) begin
    if(~reset_b) registerData <= initialValue;
    else if(clear) registerData <= initialValue;
    else if(load) registerData <= loadData; // q <= d
  end

endmodule



module fullAdderCell(
  input x,
  input y,
  input carryIn,
  output z,
  output carryOut
);

  assign z = x ^ y ^ carryIn;
  assign carryOut = (x & y) | (y & carryIn) | (x & carryIn);

endmodule



module counter #(
  parameter width = 8,
  parameter initialValue = 8'hff  
)(
  input clk,
  input reset_b,
  input increment,
  input clear,
  output reg [width-1:0]q
);

  always@(posedge clk or negedge reset_b) begin
    if(~reset_b) q <= initialValue;
    else begin
      if(clear) q <= initialValue;
      else if(increment) q <= q + 1;
    end
  end

endmodule



module decoder#(
  parameter width = 3
)(
  input [width-1:0]sel,
  input writeEnable,
  output reg [2**width-1:0]out
);

  always@(*) begin
    out = 0;
    out[sel] = writeEnable ? 1 : 0; // bitul sel din out devine 1 daca este enabled sa scriem in registru
  end
  
endmodule



module triStateDriverParamWidth #(
  parameter width = 4
)(
  input [width-1:0]in,
  input enable,
  output [width-1:0]out
);

  assign out = enable ? in : {width{1'bz}};

endmodule

module muxParamWidth #(
  parameter width = 4
)(
  input [width-1:0]d0, d1, d2, d3,
  input [1:0]sel,
  output [width-1:0]o
);

  wire [3:0]enable;
  
  decoder2_4 decoder(.sel(sel), .enable(enable));

  triStateDriverParamWidth #(4) tspw0 (.in(d0), .enable(enable[0]), .out(o));
  triStateDriverParamWidth #(4) tspw1 (.in(d1), .enable(enable[1]), .out(o));
  triStateDriverParamWidth #(4) tspw2 (.in(d2), .enable(enable[2]), .out(o));
  triStateDriverParamWidth #(4) tspw3 (.in(d3), .enable(enable[3]), .out(o));

endmodule



module multiOperandAdder #(
  parameter width = 8
)(
  input clk,
  input reset_b,
  input [width-1:0]valueToAdd,
  output reg [width-1:0]value
);
  
  always@(posedge clk or negedge reset_b) begin
    if(~reset_b) value <= 0;
    else value <= value + valueToAdd;
  end

endmodule



module compare2Bits(
  input [1:0]x,
  input [1:0]y,
  output reg equal,
  output reg lessThan,
  output reg greaterThan
);

  always@(*) begin
    equal = 0; lessThan = 0; greaterThan = 0; 
    if(x == y) equal = 1;
    else if(x < y) lessThan = 1;
    else if(x > y) greaterThan = 1;
  end

endmodule