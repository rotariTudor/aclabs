library verilog;
use verilog.vl_types.all;
entity div3 is
    port(
        i               : in     vl_logic_vector(3 downto 0);
        o               : out    vl_logic_vector(2 downto 0)
    );
end div3;
