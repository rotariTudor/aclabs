library verilog;
use verilog.vl_types.all;
entity \register\ is
    port(
        d               : in     vl_logic;
        ld              : in     vl_logic;
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        q               : out    vl_logic
    );
end \register\;
