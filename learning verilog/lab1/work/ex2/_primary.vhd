library verilog;
use verilog.vl_types.all;
entity ex2 is
    port(
        i               : in     vl_logic_vector(2 downto 0);
        o               : out    vl_logic
    );
end ex2;
