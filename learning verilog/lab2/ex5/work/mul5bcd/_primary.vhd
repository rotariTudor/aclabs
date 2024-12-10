library verilog;
use verilog.vl_types.all;
entity mul5bcd is
    port(
        i               : in     vl_logic_vector(3 downto 0);
        d               : out    vl_logic_vector(3 downto 0);
        u               : out    vl_logic_vector(3 downto 0)
    );
end mul5bcd;
