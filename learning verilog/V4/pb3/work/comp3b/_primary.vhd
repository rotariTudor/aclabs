library verilog;
use verilog.vl_types.all;
entity comp3b is
    port(
        x               : in     vl_logic_vector(2 downto 0);
        y               : in     vl_logic_vector(2 downto 0);
        o               : out    vl_logic_vector(2 downto 0)
    );
end comp3b;
