library verilog;
use verilog.vl_types.all;
entity mux4to1_16b is
    port(
        ip0             : in     vl_logic_vector(15 downto 0);
        ip1             : in     vl_logic_vector(15 downto 0);
        ip2             : in     vl_logic_vector(15 downto 0);
        ip3             : in     vl_logic_vector(15 downto 0);
        ctrl_sig        : in     vl_logic_vector(1 downto 0);
        op              : out    vl_logic_vector(15 downto 0)
    );
end mux4to1_16b;
