library verilog;
use verilog.vl_types.all;
entity seq3b is
    port(
        i               : in     vl_logic_vector(3 downto 0);
        o               : out    vl_logic
    );
end seq3b;
