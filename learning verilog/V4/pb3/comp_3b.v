module comp3b(input [2:0] x, input [2:0] y, output [2:0] o);
    wire eq2, gr2, le2; 
    wire eq1, gr1, le1; 
    wire eq0, gr0, le0; 

    rel bit2(.m(x[2]), .n(y[2]), .eq(eq2), .gr(gr2), .le(le2));
    rel bit1(.m(x[1]), .n(y[1]), .eq(eq1), .gr(gr1), .le(le1));
    rel bit0(.m(x[0]), .n(y[0]), .eq(eq0), .gr(gr0), .le(le0));

    assign o[2] = gr2 | (eq2 & gr1) | (eq2 & eq1 & gr0);  
    assign o[1] = eq2 & eq1 & eq0;                       
    assign o[0] = le2 | (eq2 & le1) | (eq2 & eq1 & le0);  
endmodule


module rel(input m, input n, output reg eq, output reg gr, output reg le);
  always@(*)begin
    if(m>n)begin gr=1; eq=0; le=0; end
    else if(m<n)begin le=1;  gr=0; eq=0;end
    else begin eq=1; gr=0; le=0; end
  end
endmodule


module tb_comp_3b;
    reg [2:0] x, y;
    wire [2:0] o;
    
    reg a,b;
    wire lt,gt,eq;

    comp3b CUT (
        .x(x),
        .y(y),
        .o(o)
    );
    
    //rel CUT(.m(a),.n(b),.eq(eq),.gr(gt),.le(lt));

    initial begin
        $monitor("x = %b, y = %b, o = %b", x, y, o);
        //$monitor("a:%b, b:%b, eq:%b, lt:%b, gt:%b", a, b, eq,lt,gt);
        // Testare diverse cazuri
        x = 3'b011; y = 3'b010; #10;  // x > y
        x = 3'b010; y = 3'b010; #10;  // x == y
        x = 3'b001; y = 3'b010; #10;  // x < y
        //a=0; b = 1; #10;
        //b = 1; a = 1; #10;
        //a = 1; b = 0; #10;
        $stop;
    end
endmodule
