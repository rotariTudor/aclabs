module mux_2s #(parameter w = 4)(input [w-1:0] d0,d1,d2,d3, input [1:0] s, output[w-1:0] o);
  assign o = (s == 2'b00) ? d0:(s == 2'b01) ? d1:(s == 2'b10) ? d2:(s == 2'b11) ? d3: {w{1'bz}};
endmodule

module mux_2s_tb();
  localparam w = 4;
  reg [w-1:0]d0,d1,d2,d3;
  reg [1:0]s;
  wire [w-1:0]o;
  integer i;
  
  mux_2s CUT(.d0(d0),.d1(d1),.d2(d2),.d3(d3),.s(s),.o(o));
  
  initial begin
    d0 = 4'b0001; d1 = 4'b0010; d2 = 4'b0100; d3 = 4'b1000;
    $display("TIME\tD0\tD1\tD2\tD3\tSEL\tOUTPUT");
    {s}=0;
    $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b",$time,d0,d1,d2,d3,s,o);
    for(i=1;i<4;i=i+1)begin
      #20 s=i;
    end
  end
endmodule
  