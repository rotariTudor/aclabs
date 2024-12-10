module dec2x4(
    input [1:0] s,
    input e,
    output reg [3:0] y
);
    always @(*)
        casez ({e, s})
            3'b100: y = 4'b1110;
            3'b101: y = 4'b1101;
            3'b110: y = 4'b1011;
            3'b111: y = 4'b0111;
            3'b0??: y = 4'b1111;
        endcase
endmodule

module dec2x4_tb();
  reg [1:0] s;
  reg e;
  wire y;
  
  dec2x4 decod1(.s(s),.e(e),.y(y));
  integer i;
  initial begin 
    $display("Time\tE\tS\tY\t");

    for(i=0;i<8;i=i+1)begin
      #10 {e,s} = i;
      $monitor("%0t\t%b\t%b\t%b\t",$time,e,s,y);
    end  
  end
endmodule