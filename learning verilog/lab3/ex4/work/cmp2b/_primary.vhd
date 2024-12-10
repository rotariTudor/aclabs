library verilog;
use verilog.vl_types.all;
entity cmp2b is
    port(
        x               : in     vl_logic_vector(1 downto 0);
        y               : in     vl_logic_vector(1 downto 0);
        eq              : out    vl_logic;
        lt              : out    vl_logic;
        gt              : out    vl_logic
    );
end cmp2b;
