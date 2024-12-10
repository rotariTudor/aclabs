module rgst #(
    parameter w = 8,
    parameter iv = {w{1'b0}}
)(
    input clk,
    input rstb,
    input [w-1:0] d,
    input ld,
    input clr,
    output reg [w-1:0] q
);
    always @(posedge clk, negedge rstb)
        if (!rstb)
            q <= iv;
        else if (clr)
            q <= iv;
        else if (ld)
            q <= d;
endmodule

`timescale 1ns/1ps

module tb_rgst;
    parameter w = 8;
    parameter iv = {w{1'b0}};

    reg clk;
    reg rstb;
    reg [w-1:0] d;
    reg ld;
    reg clr;
    wire [w-1:0] q;

    rgst #(
        .w(w),
        .iv(iv)
    ) uut (
        .clk(clk),
        .rstb(rstb),
        .d(d),
        .ld(ld),
        .clr(clr),
        .q(q)
    );

    
    initial clk = 0;
    always #5 clk = ~clk; 

    
    initial begin
        
        rstb = 0; d = 0; ld = 0; clr = 0;

        
        #10 rstb = 1; 
        #10 rstb = 0; 
        #10 rstb = 1; 

        
        #10 d = 8'hA5; ld = 1; 
        #10 ld = 0; 

        
        #10 clr = 1;
        #10 clr = 0;

        
        #10 d = 8'h3C; ld = 1;
        #10 ld = 0;

      
        #50 $finish;
    end

    initial begin
        $monitor($time, " rstb=%b clr=%b ld=%b d=%h q=%h", rstb, clr, ld, d, q);
    end
endmodule

