library verilog;
use verilog.vl_types.all;
entity check is
    generic(
        w               : integer := 4
    );
    port(
        \in\            : in     vl_logic_vector;
        o               : out    vl_logic
    );
end check;
