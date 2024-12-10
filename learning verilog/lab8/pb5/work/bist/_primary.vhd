library verilog;
use verilog.vl_types.all;
entity bist is
    port(
        clk             : in     vl_logic;
        rst_b           : in     vl_logic;
        sig             : out    vl_logic_vector(3 downto 0)
    );
end bist;
