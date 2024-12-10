library verilog;
use verilog.vl_types.all;
entity karnaugh is
    generic(
        w               : integer := 4
    );
    port(
        \in\            : in     vl_logic_vector(3 downto 0);
        o               : out    vl_logic_vector(1 downto 0)
    );
end karnaugh;
