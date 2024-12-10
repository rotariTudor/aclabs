
//decodificator
module dec #(parameter w=2)(
	input [w-1:0] s,
	input e,
	output reg [2**w-1:0] o
);
	always @ (*) begin
		o = 0;
		if (e)
  		  o[s] = 1;
	end
endmodule

//registru
module rgst #(
    paramtere w=8
    )(
    input clk,rst_b,ld,clr,
    input[7:0]d,
    output reg[7:0]o
    );

    always@(posedge clk,negedge rst_b)
      if(!rst_b) q<=0;
      else if(clr) q<=0;
        else if(ld) q<=d;

endmodule

module regfl(input clk,
    input rst_b,
    input we,
    input [2:0]s,
    input [63:0]d,
    output [511:0]q
    );
    
    wire [7:0]o;
    
    dec #(.w(3)) dec1 (.s(s),.e(we),.o(o));
    
    generate 
      genvar i;
      for(i=0;i<8;i=i+1)begin : loop
        rgst #(.w(64)) register
            (.clk(clk),
            .clr(1'b0),
            .rst_b(rst_b),
            .ld(o[i]),
            .d(d),
            q(q[((64*(8-i))-1):64*(7-i))])
            );
      end
    endgenerate
endmodule

