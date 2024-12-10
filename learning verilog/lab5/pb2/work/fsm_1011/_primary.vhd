library verilog;
use verilog.vl_types.all;
entity fsm_1011 is
    port(
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        i               : in     vl_logic;
        o               : out    vl_logic
    );
end fsm_1011;
