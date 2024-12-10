library verilog;
use verilog.vl_types.all;
entity dec2x4 is
    port(
        s               : in     vl_logic_vector(1 downto 0);
        e               : in     vl_logic;
        y               : out    vl_logic_vector(3 downto 0)
    );
end dec2x4;
