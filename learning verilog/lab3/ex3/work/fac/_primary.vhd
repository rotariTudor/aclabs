library verilog;
use verilog.vl_types.all;
entity fac is
    port(
        x               : in     vl_logic;
        y               : in     vl_logic;
        cin             : in     vl_logic;
        sum             : out    vl_logic;
        carryout        : out    vl_logic
    );
end fac;
