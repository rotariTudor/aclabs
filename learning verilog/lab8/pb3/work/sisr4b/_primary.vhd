library verilog;
use verilog.vl_types.all;
entity sisr4b is
    port(
        \in\            : in     vl_logic;
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        q               : out    vl_logic_vector(3 downto 0)
    );
end sisr4b;
