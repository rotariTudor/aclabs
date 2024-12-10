library verilog;
use verilog.vl_types.all;
entity sadd is
    port(
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        \in\            : in     vl_logic_vector(1 downto 0);
        z               : out    vl_logic
    );
end sadd;
