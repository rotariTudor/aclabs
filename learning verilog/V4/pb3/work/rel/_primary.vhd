library verilog;
use verilog.vl_types.all;
entity rel is
    port(
        m               : in     vl_logic;
        n               : in     vl_logic;
        eq              : out    vl_logic;
        gr              : out    vl_logic;
        le              : out    vl_logic
    );
end rel;
