library verilog;
use verilog.vl_types.all;
entity mux2to1_3b is
    port(
        ip0             : in     vl_logic_vector(2 downto 0);
        ip1             : in     vl_logic_vector(2 downto 0);
        ctrl_sig        : in     vl_logic;
        op              : out    vl_logic_vector(2 downto 0)
    );
end mux2to1_3b;
