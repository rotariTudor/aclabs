module mux_2s #(
        parameter w = 4
)(
        input [w-1:0]d0,d1,d2,d3,
        input [1:0]s,
        output[w-1:0] o);

  always@(*)begin
    case(s):
      2'b00:o=d0;
      2'b01:o=d1;
      2'b10:o=d2;
      2'b11:o=d3;
  end
endmodule