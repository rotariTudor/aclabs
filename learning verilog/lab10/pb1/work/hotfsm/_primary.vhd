library verilog;
use verilog.vl_types.all;
entity hotfsm is
    port(
        a               : in     vl_logic;
        b               : in     vl_logic;
        c               : in     vl_logic;
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        m               : out    vl_logic;
        n               : out    vl_logic
    );
end hotfsm;
